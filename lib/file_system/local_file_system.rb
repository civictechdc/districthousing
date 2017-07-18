# coding: utf-8
# frozen_string_literal: true

require 'digest/md5'
require 'win32/file/attributes' if Gem.win_platform?

module GDSync
  # FileSystem implementation for local storage.
  class LocalFileSystem < FileSystem
    # AbstractFile implementation for LocalFileSystem.
    class File < AbstractFile
      def initialize(fs, path)
        @fs = fs
        @path = path
        @md5 = nil
      end

      def title
        ::File.basename(@path)
      end

      def size
        ::File.size(@path)
      end

      def mtime
        ::File.mtime(@path).to_datetime
      end

      def md5
        @md5 ||= ::Digest::MD5.file(@path).to_s
        @md5
      end

      attr_reader :fs

      def create_read_io
        open(@path, 'rb')
      end

      def write_to(write_io)
        open(@path, 'rb') do |f|
          ::IO.copy_stream(f, write_io)
        end
      end

      def copy_to(dest_dir, _birthtime, mtime)
        file, io = dest_dir.create_write_io!(title)
        write_to(io)
        io.close
        ::File.utime(mtime.to_time, mtime.to_time, file.path)

        file
      end

      def update!(read_io, mtime)
        open(@path, 'wb') do |f|
          ::IO.copy_stream(read_io, f)
        end
        ::File.utime(mtime.to_time, mtime.to_time, @path)
      end

      def delete!
        3.times do
          begin
            ::FileUtils.remove_entry_secure(@path)
          rescue
          end
          break unless ::File.exist?(@path)
        end
        raise "cannot delete file #{@path}" if ::File.exist?(@path)
      end

      attr_reader :path

      def birthtime
        f = ::File.new(@path)
        begin
          f.birthtime.to_datetime
        rescue ::NotImplementedError
          f.mtime.to_datetime
        rescue ::NoMethodError
          f.mtime.to_datetime
        end
      end
    end

    # AbstractDir implementation for LocalFileSystem.
    class Dir < AbstractDir
      def initialize(fs, path)
        @fs = fs
        @path = path
      end

      def title
        ::File.basename(@path)
      end

      def entries(&_block)
        dirs = []
        files = []

        ::Dir.entries(@path, encoding: ::Encoding::UTF_8)
             .select { |e| e != '.' && e != '..' }
             .sort
             .each do |e|
               path = ::File.join(@path, e)
               if ::Gem.win_platform?
                 begin
                   # ::File.hidden? may raise Errno:EXXX error.
                   next if ::File.hidden?(path)
                 rescue
                 end
               end
               if ::File.directory?(path)
                 dirs << Dir.new(@fs, path)
               else
                 files << File.new(@fs, path)
               end
             end

        (dirs + files).each { |f| yield(f) }

        true
      end

      attr_reader :fs

      def create_dir!(title)
        newpath = ::File.join(@path, title)
        ::Dir.mkdir(newpath)
        Dir.new(@fs, newpath)
      end

      def create_file_with_read_io!(io, title, mtime, _birthtime)
        newfile = ::File.join(@path, title)
        open(newfile, 'wb') do |f|
          ::IO.copy_stream(io, f)
        end
        ::File.utime(mtime, mtime, newfile)
        File.new(@fs, newfile)
      end

      def create_write_io!(title)
        newfile = ::File.join(@path, title)
        io = open(newfile, 'wb')
        file = File.new(@fs, newfile)
        return file, io
      end

      def delete!
        3.times do
          begin
            ::FileUtils.remove_entry_secure(@path)
          rescue
          end
          break unless ::File.exist?(@path)
        end
      end

      attr_reader :path
    end

    def can_create_io_stream?
      true
    end

    def find(path)
      if ::File.exist?(path)
        if ::File.directory?(path)
          Dir.new(self, path)
        else
          File.new(self, path)
        end
      end
    end
  end
end
