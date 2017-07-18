# coding: utf-8
# frozen_string_literal: true

module GDSync
  # Dummy filesystem for --dry-run.
  class DryRunFileSystem < FileSystem
    # Dummy File for --dry-run.
    class File < AbstractFile
      attr_reader :fs, :path

      def initialize(fs, path)
        @fs = fs
        @path = path
      end

      def title
        ::File.basename(path)
      end

      def size
        0
      end

      def mtime
        ::DateTime.now
      end

      def birthtime
        ::DateTime.now
      end

      def md5
        ::Digest::MD5.hexdigest('')
      end

      def create_read_io
        raise NotSupportedError
      end

      def write_to(_write_io)
      end

      def update!(_read_io, _mtime)
        self
      end

      def copy_to(dest_dir)
        File.new(::File.join(dest_dir.path, title))
      end

      def delete!
      end
    end

    # Dummy Dir for --dry-run.
    class Dir < AbstractDir
      attr_reader :fs
      attr_reader :path

      def initialize(fs, path)
        @fs = fs
        @path = path
      end

      def title
        ::File.basename(path)
      end

      def entries(&_block)
        true
      end

      def create_dir!(title)
        Dir.new(fs, ::File.join(path, title))
      end

      def create_file_with_read_io!(_io, title, _mtime, _birthtime)
        File.new(fs, ::File.join(path, title))
      end

      def create_write_io!(_title)
        raise NotSupportedError
      end

      def delete!
      end
    end

    def can_create_io_stream?
      false
    end
  end
end
