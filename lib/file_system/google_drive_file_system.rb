# coding: utf-8
# frozen_string_literal: true

require 'google_drive'

module GDSync
  # FileSystem implementation for Google Drive.
  class GoogleDriveFileSystem < FileSystem
    URL_SCHEMA = 'googledrive://'.freeze

    # Google Drive api request limit in 100 seconds.
    # Default value is: requests per 100 seconds per user := 1,000 
    # See: https://console.developers.google.com/apis/api/drive/quotas
    API_RATE_LIMIT = 1000

    # API call will be rejected if the number of api call exceeds #{API_RATE_LIMIT} in #{API_RATE_LIMIT_WINDOW} seconds.
    API_RATE_LIMIT_WINDOW = 100.0

    # AbstractFile implementation for GoogleDriveFileSystem.
    class File < AbstractFile
      # @param  [GoogleDriveFileSystem]  fs
      # @param  [GoogleDrive::File] gd_file
      # @param  [String] path
      def initialize(fs, gd_file, path)
        @fs = fs
        @file = gd_file
        @path = path
      end

      def title
        @file.title
      end

      def size
        @file.size.to_i
      end

      def mtime
        @file.api_file.modified_time
      end

      def md5
        @file.api_file.md5_checksum
      end

      attr_reader :fs

      def create_read_io
        raise ::GDSync::FileSystem::NotSupportedError
      end

      def write_to(write_io)
        @fs.call_api(@file, :download_to_io, write_io)
      end

      def copy_to(dest_dir, _birthtime, mtime)
        request_object = {
          name: title,
          parents: [dest_dir.id],
          modified_time: mtime.rfc3339
        }
        params = {
        }
        api_file = @fs.call_api(@fs.session.drive, :copy_file, @file.id, request_object, params)
        file = @fs.session.wrap_api_file(api_file)
        if file.nil?
          nil
        else
          @fs.call_api(file, :reload_metadata)
          File.new(@fs, file, ::File.join(dest_dir.path, title))
        end
      end

      def update!(read_io, mtime)
        request_object = {
          modified_time: mtime.rfc3339
        }
        params = {
          upload_source: read_io
        }
        api_file = @fs.call_api(@fs.session.drive, :update_file, @file.id, request_object, params)
        file = @fs.session.wrap_api_file(api_file)
        @fs.call_api(file, :reload_metadata)
        File.new(@fs, file, @path)
      end

      def delete!
        @file.delete
      end

      attr_reader :path

      def birthtime
        @file.api_file.created_time
      end
    end

    # AbstractDir implementation for GoogleDriveFileSystem
    class Dir < AbstractDir
      # @param  [GoogleDriveFileSystem]  fs
      # @param  [GoogleDrive::Collection]  gd_collection
      # @param  [String] path
      def initialize(fs, gd_collection, path)
        @fs = fs
        @collection = gd_collection
        @path = path
      end

      def title
        @collection.title
      end

      def entries(&_block)
        dirs = []
        files = []
        begin
          @fs.call_api(@collection, :files) do |file|
            unless file.explicitly_trashed
              if file.is_a?(::GoogleDrive::Collection)
                dirs << file
              else
                files << file
              end
            end
          end
        rescue
          return false
        end

        dirs.sort! { |a, b| a.title <=> b.title }
        files.sort! { |a, b| a.title <=> b.title }
        dirs.each do |file|
          yield(Dir.new(@fs, file, ::File.join(@path, file.title)))
        end
        files.each do |file|
          yield(File.new(@fs, file, ::File.join(@path, file.title)))
        end

        true
      end

      attr_reader :fs

      def create_dir!(title)
        begin
          created = @fs.call_api(@collection, :create_subcollection, title)
          return Dir.new(@fs, created, ::File.join(@path, title)) unless created.nil?
        rescue
          return nil
        end
      end

      def create_file_with_read_io!(io, title, mtime, birthtime)
        params = {
          upload_source: io,
          content_type: 'application/octet-stream',
          fields: '*'
        }
        request_object = {
          name: title,
          parents: [@collection.id],
          modified_time: mtime.rfc3339,
          created_time: birthtime.rfc3339
        }

        dest_file = nil

        begin
          api_file = @fs.call_api(@fs.session.drive, :create_file, request_object, params)
          dest_file = @fs.session.wrap_api_file(api_file)
        rescue
          return nil
        end

        File.new(@fs, dest_file, ::File.join(@path, title))
      end

      def create_write_io!(_title)
        raise ::GDSync::FileSystem::NotSupportedError
      end

      def delete!
        @collection.delete
      end

      attr_reader :path

      # Get Google Drive file id.
      # @return [String]
      def id
        @collection.id
      end
    end

    def initialize(config_file_path)
      if ::Gem.win_platform?
        # "OpenSSL::X509::DEFAULT_CERT_FILE" may point to invalid location,
        # typically depending on who build the RubyInstaller. (ex. "C:/Users/(someone)/Projects/knap-build/...")
        # So we have to set correct *.pem file path. Fortunately, 'google-api-client' provides valid 'cacerts.pem' file.
        cert_path = ::File.join(::Gem.loaded_specs['google-api-client'].full_gem_path, 'lib', 'cacerts.pem')
        ENV['SSL_CERT_FILE'] = cert_path if ::File.exist?(cert_path)
      end
      @session = ::GoogleDrive.saved_session(config_file_path)
      # Stores ::Time for each API call.
      @api_call_history = []
    end

    def can_create_io_stream?
      false
    end

    def find(file)
      return nil unless file.start_with?(URL_SCHEMA)
      return Dir.new(self, @session.root_collection, URL_SCHEMA) if file == URL_SCHEMA

      end_with_slash = file.end_with?('/')
      file = file.slice(0, file.size - 1) if end_with_slash
      path_elements = file.split(URL_SCHEMA)[1].split('/')
      path = URL_SCHEMA

      collection = @session.root_collection
      path_elements.each do |path_element|
        path = ::File.join(path, path_element)

        # find directory first.
        child = call_api(collection, :subcollection_by_title, path_element)
        unless child.nil?
          child = nil if child.explicitly_trashed
        end

        if file == path
          return Dir.new(self, child, "#{path}#{end_with_slash ? '/' : ''}") unless child.nil?

          # directory not found. then search file
          child = call_api(collection, :file_by_title, path_element)
          return nil if child.nil?

          return nil if child.explicitly_trashed
          return File.new(self, child, path)
        else
          return nil if child.nil?
          collection = child
        end
      end

      nil
    end

    # Get GoogleDrive::Session object.
    # @return [GoogleDrive::Session]
    attr_reader :session

    # Call Google Drive API related method
    # @param [Object] object
    # @param [String] method_name
    def call_api(object, method_name, *args, &block)
      now = ::Time.now

      @api_call_history.delete_if { |t| t < now - API_RATE_LIMIT_WINDOW }

      if @api_call_history.size >= API_RATE_LIMIT
        seconds_to_sleep = @api_call_history[0] + API_RATE_LIMIT_WINDOW - now

        if seconds_to_sleep > 0
          sleep(seconds_to_sleep)
          slept_now = ::Time.now
          @api_call_history.delete_if { |t| t < slept_now - API_RATE_LIMIT_WINDOW }
        end
      end

      @api_call_history << ::Time.now
      object.public_send(method_name, *args, &block)
    end
  end
end
