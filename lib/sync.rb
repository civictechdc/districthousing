# coding: utf-8
# frozen_string_literal: true

require_relative 'file_system'
require_relative 'file_system/google_drive_file_system'
require_relative 'file_system/local_file_system'
require_relative 'file_system/dry_run'
require_relative 'option'

module GDSync
  # File sync operator between two FileSystem's.
  class Sync
    # @param src [Array]
    # @param dest [String]
    # @param option [Option]
    def initialize(src, dest_dir, option)
      @googledrive_fs = nil
      @local_fs = nil

      @googledrive_config_path = _prepare_config_file

      @src = src.map { |file| file.encode(::Encoding::UTF_8) }
      @dest = dest_dir.encode(::Encoding::UTF_8)
      @option = option
    end

    def local_fs
      @local_fs ||= LocalFileSystem.new
      @local_fs
    end

    def dryrun_fs
      @dryrun_fs ||= DryRunFileSystem.new
      @dryrun_fs
    end

    def googledrive_fs
      @googledrive_fs ||= GoogleDriveFileSystem.new(@googledrive_config_path)
      @googledrive_fs
    end

    def run
      @src.each do |src_string|
        src = _lookup_file_or_dir(src_string)

        raise "file or directory '#{src_string}' not found" if src.nil?

        if src.dir?
          if @option.recursive? || @option.dirs?
            dest = _lookup_dir(@dest)

            if !dest.nil? && !src.path.end_with?('/')
              sub = _lookup_dir(::File.join(@dest, src.title))
              if sub.nil? && !@option.existing?
                sub = _create_new_dir(src.title, dest)
                raise "cannot create directory '#{::File.join(@dest, src.title)}'" if sub.nil?
              end
              dest = sub
            end

            if dest.nil?
              raise 'cannot find dest directory' unless @option.existing?
            else
              _transfer_directory_contents_recursive(src, dest) unless @option.dirs? && !src.path.end_with?('/')
            end
          else
            @option.log_skip(src)
          end
        else
          dest = _lookup_dir(@dest)
          raise 'cannot find dest directory' if dest.nil?

          dest_existing_file = dest.fs.find(::File.join(dest.path, src.title))
          _transfer_file(src, dest, dest_existing_file)
        end
      end
    end

    private

    def _prepare_config_file
      path = ::File.join(::File.dirname(__FILE__), '..', 'config.json')
      unless ::File.exist?(path)
        # Create first 'config.json'.
        # These id and secret are for gdsync itself, not for end user.
        # So, the 'client_secret' can be embedded here.
        # See https://developers.google.com/identity/protocols/OAuth2#installed
        initial_config = {
          client_id: '788008427451-1h3lt65qc87afhcm1fvh1h3gliut5ivq.apps.googleusercontent.com',
          client_secret: 'Wptl4qR3JIiF0mENVqKmyIun'
        }
        open(path, 'wb') do |file|
          file.write(::JSON.generate(initial_config))
        end
      end
      path
    end

    def _lookup_file_or_dir(path)
      if path.start_with?(GoogleDriveFileSystem::URL_SCHEMA)
        googledrive_fs.find(path)
      else
        local_fs.find(path)
      end
    end

    # @param dir [String]
    def _lookup_dir(dir)
      d = _lookup_file_or_dir(dir)
      return nil if d.nil?
      return nil unless d.dir?
      d
    end

    # @param src [AbstractFile]
    # @param  dest_dir [AbstractDir]
    # @return [AbstractFile]
    def _create_new_file(src, dest_dir)
      created = nil
      now = ::DateTime.now
      mtime = @option.preserve_time? ? src.mtime : now
      birthtime = @option.preserve_time? ? src.birthtime : now

      if @option.dry_run?
        created = DryRunFileSystem::File.new(dryrun_fs, ::File.join(dest_dir.path, src.title))
      elsif dest_dir.fs.instance_of?(src.fs.class)
        # copy file between same filesystem.
        created = src.copy_to(dest_dir, birthtime, mtime)
      elsif src.fs.can_create_io_stream?
        # typically Local to Remote copy.
        read_io = src.create_read_io
        created = dest_dir.create_file_with_read_io!(read_io, src.title, mtime, birthtime)
        read_io.close
      elsif dest_dir.fs.can_create_io_stream?
        # typically Remote to Local copy.
        created, io = dest_dir.create_write_io!(src.title)
        src.write_to(io)
        io.close
      else
        @option.error('filesystem does not provide any file copy function')
      end

      created
    end

    # @param title [String]
    # @param dest_dir [AbstractDir]
    # @return [AbstractDir]
    def _create_new_dir(title, dest_dir)
      dir = if @option.dry_run?
              DryRunFileSystem::Dir.new(dryrun_fs, ::File.join(dest_dir.path, title))
            else
              dest_dir.create_dir!(title)
            end

      if dir.nil?
        @option.error("cannot create subdirectory '#{::File.join(dest_dir.path, title)}'")
      else
        @option.log_created(dir)
      end

      dir
    end

    def _transfer_file(src_file, dest_dir, dest_existing_file)
      mtime = @option.preserve_time? ? src_file.mtime : ::DateTime.now

      size = src_file.size
      return if size > @option.max_size
      return if size < @option.min_size

      if dest_existing_file.nil?
        unless @option.existing?
          # file does not exist. so, create new file.
          created = _create_new_file(src_file, dest_dir)

          if created.nil?
            @option.error("cannot create file '#{::File.join(dest_dir.path, src_file.title)}'")
          else
            @option.log_created(created)
          end
        end
      else
        unless @option.ignore_existing?
          # file already exists.
          updated = nil

          unless @option.should_update?(src_file, dest_existing_file)
            @option.log_skip(dest_existing_file)
            return
          end

          if @option.dry_run?
            updated = DryRunFileSystem::File.new(dryrun_fs, dest_existing_file.path)
          elsif src_file.fs.can_create_io_stream?
            read_io = src_file.create_read_io
            updated = dest_existing_file.update!(read_io, mtime)
            read_io.close
          else
            dest_existing_file.delete!
            updated = _create_new_file(src_file, dest_dir)
          end

          if updated.nil?
            @option.error("cannot update file '#{dest_existing_file.path}'")
          else
            @option.log_updated(updated)
          end
        end
      end
    end

    def _transfer_directory_contents_recursive(src_dir, dest_dir)
      # list existing dirs/files in the 'dest_dir'.
      existing_dirs = []
      existing_files = []
      ok = dest_dir.entries do |entry|
        if entry.dir?
          existing_dirs << entry
        else
          existing_files << entry
        end
      end
      unless ok
        @option.error("cannot enumerate directory contents: #{dest_dir.path}")
      end

      ok = src_dir.entries do |src|
        if src.dir?
          # search dir in 'dest_dir' with same title.
          dir = existing_dirs.select { |f| f.title == src.title }.first

          existing_dirs.delete_if { |f| f.title == src.title }

          if !@option.recursive? && !@option.dirs?
            @option.log_skip(src)
            next
          end

          if dir.nil? && !@option.existing?
            dir = _create_new_dir(src.title, dest_dir)
          end

          if !dir.nil? && !@option.dirs?
            _transfer_directory_contents_recursive(src, dir)
          end
        else
          # search file in 'dest_dir' with same title.
          file = existing_files.select { |f| f.title == src.title }.first

          existing_files.delete_if { |f| f.title == src.title }

          _transfer_file(src, dest_dir, file)

          if @option.remove_source_files? && !@option.existing?
            src.delete! unless @option.dry_run?
            @option.log_deleted(src)
          end
        end
      end
      unless ok
        @option.error("cannot enumerate directory contents: #{src_dir.path}")
      end

      if @option.delete?
        existing_dirs.each do |dir|
          dir.delete! unless @option.dry_run?
          @option.log_deleted(dir)
        end
        existing_files.each do |file|
          file.delete! unless @option.dry_run?
          @option.log_deleted(file)
        end
      else
        existing_dirs.each do |dir|
          @option.log_extraneous(dir)
        end
        existing_files.each do |file|
          @option.log_extraneous(file)
        end
      end
    end
  end
end
