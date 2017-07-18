# coding: utf-8
# frozen_string_literal: true

module GDSync
  # Abstract class that represents filesystem.
  class FileSystem
    class NotSupportedError < RuntimeError
    end

    # Abstract class that represents a file on the filesystem.
    class AbstractFile
      # Returns file name.
      # @return [String]
      def title
        raise "abstract method '#{__callee__}' called"
      end

      # Path string (ex. "googledrive://Some/Directory/sample.txt")
      # @return [String]
      def path
        raise "abstract method '#{__callee__}' called"
      end

      def dir?
        false
      end

      # File size in bytes.
      # @return [Integer]
      def size
        raise "abstract method '#{__callee__}' called"
      end

      # Last modified time.
      # @return [DateTime]
      def mtime
        raise "abstract method '#{__callee__}' called"
      end

      # Created time
      # @return [DateTime]
      def birthtime
        raise "abstract method '#{__callee__}' called"
      end

      # MD5 checksum.
      # @return [String]
      def md5
        raise "abstract method '#{__callee__}' called"
      end

      # A FileSystem object which manages this AbstractFile object.
      # @return [FileSystem]
      def fs
        raise "abstract method '#{__callee__}' called"
      end

      # Creates IO object to read the file.
      # @return [IO]
      # @raise NotSupportedError when 'create_read_io' operation is not supported by the filesystem.
      def create_read_io
        raise "abstract method '#{__callee__}' called"
      end

      # Read this file and write to 'write_io' IO object.
      # @param write_io [IO]
      def write_to(_write_io)
        raise "abstract method '#{__callee__}' called"
      end

      # Read from @a read_io and write to this file.
      # @param read_io [IO]
      # @param mtime [DateTime] New last modified datetime of this file.
      # @return [AbstractFile]
      def update!(_read_io, _mtime)
        raise "abstract method '#{__callee__}' called"
      end

      # Copy file to 'dest_dir'. self and dest_dir must be same filesystem.
      # @param dest_dir [AbstractDir]
      # @param birthtime [DateTime]
      # @param mtime [DateTime]
      # @pre self.fs == dest_dir.fs
      # @return  [AbstractFile]  AbstractFile object pointing to copied file.
      def copy_to(_dest_dir, _birthtime, _mtime)
        raise "abstract method '#{__callee__}' called"
      end

      # Delete file.
      def delete!
        raise "abstract method '#{__callee__}' called"
      end
    end

    # Abstract class that represents a directory on the filesystem.
    class AbstractDir
      # Name of directory
      # @return [String]
      def title
        raise "abstract method '#{__callee__}' called"
      end

      def dir?
        true
      end

      # Enumerate contents of directory.
      # Should be enumerated directories with lexical order at first, then files with lexical order.
      # @return [Boolean] true if successfully enumerated.
      def entries(&_block)
        raise "abstract method '#{__callee__}' called"
      end

      # A FileSystem object which manages this AbstractDir object.
      # @return [FileSystem]
      def fs
        raise "abstract method '#{__callee__}' called"
      end

      # Create sub directory.
      # @param title [String]
      # @return [AbstractDir] AbstractDir object pointing to created directory.
      def create_dir!(_title)
        raise "abstract method '#{__callee__}' called"
      end

      # Upload a file with 'title' by reading 'io', and return AbstractFile derived object.
      # @param io [IO]
      # @param title [String]
      # @param mtime [DateTime]
      # @parma birthtime [DateTime]
      # @return  [AbstractFile] AbstractFile object pointing to created file.
      # @raise NotSupportedError when 'create_file' operation is not supported by the filesystem.
      def create_file_with_read_io!(_io, _title, _mtime, _birthtime)
        raise "abstract method '#{__callee__}' called"
      end

      # Create a file with 'title', and return IO object to write to it.
      # @raise NotSupportedError when 'create_file' operation is not supported by the filesystem.
      # @return [AbstractFile, IO]
      def create_write_io!(_title)
        raise "abstract method '#{__callee__}' called"
      end

      # Delete directory recursively.
      def delete!
        raise "abstract method '#{__callee__}' called"
      end

      # Path string (ex. "googledrive://Some/Directory")
      # @return [String]
      def path
        raise "abstract method '#{__callee__}' called"
      end
    end

    # Return true if this filesystem can create [IO] objects for file read/write.
    # @return [Boolean]
    def can_create_io_stream?
      raise "abstract method '#{__callee__}' called"
    end

    # Find file or directory.
    # @param path [String]
    # @return [AbstractFile] or [AbstractDir] or nil
    def find(_path)
      raise "abstract method '#{__callee__}' called"
    end
  end
end
