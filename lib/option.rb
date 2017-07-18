# coding: utf-8
# frozen_string_literal: true

module GDSync
  # Runtime options for GDSync::Sync.#run
  class Option
    SUPPORTED_OPTIONS = [
      '--checksum',
      '--recursive',
      '--times',
      '--dry-run',
      '--existing',
      '--ignore-existing',
      '--delete',
      '--ignore-times',
      '--size-only',
      '--update',
      '--dirs',
      '--remove-source-files'
    ].freeze

    def initialize(options)
      @verbose = options.include?('--verbose')
      @delete = options.include?('--delete')
      @checksum = options.include?('--checksum')
      @dry_run = options.include?('--dry-run')
      @size_only = options.include?('--size-only')
      @recursive = options.include?('--recursive')
      @preserve_time = options.include?('--times')
      @ignore_times = options.include?('--ignore-times')
      @existing = options.include?('--existing')
      @ignore_existing = options.include?('--ignore-existing')
      @update = options.include?('--update')
      @dirs = options.include?('--dirs')
      @remove_source_files = options.include?('--remove-source-files')
      @max_size = _parse_size(options, '--max-size', Float::INFINITY)
      raise "--max-size value is invalid: #{@max_size}" if @max_size <= 0
      @min_size = _parse_size(options, '--min-size', 0)

      archive = options.include?('--archive')
      if archive
        @recursive = true
        @preserve_time = true
      end

      _validate
    end

    def delete?
      @delete
    end

    def verbose?
      @verbose
    end

    def dry_run?
      @dry_run
    end

    def recursive?
      @recursive
    end

    def preserve_time?
      @preserve_time
    end

    def existing?
      @existing
    end

    def ignore_existing?
      @ignore_existing
    end

    def dirs?
      if @recursive
        false
      else
        @dirs
      end
    end

    def remove_source_files?
      @remove_source_files
    end

    attr_reader :max_size

    attr_reader :min_size

    def should_update?(src_file, dest_file)
      # Ignore sub-second part of mtime.
      # This is same behavior when rsync(1) had been compiled without 'HAVE_UTIMENSAT' macro.
      return false if @update && dest_file.mtime.to_time.to_i > src_file.mtime.to_time.to_i

      if @checksum
        src_file.md5 != dest_file.md5
      elsif @size_only
        src_file.size != dest_file.size
      elsif @ignore_times
        true
      else
        src_file.size != dest_file.size || dest_file.mtime.to_time.to_i < src_file.mtime.to_time.to_i
      end
    end

    def error(msg)
      puts "Error: #{msg}"
    end

    def log_updated(file)
      puts "#{file.path}#{file.dir? ? '/' : ''} (updated)" if @verbose
    end

    def log_created(file)
      puts "#{file.path}#{file.dir? ? '/' : ''} (created)" if @verbose
    end

    def log_deleted(file)
      puts "#{file.path}#{file.dir? ? '/' : ''} (deleted)" if @verbose
    end

    def log_extraneous(file)
      puts "#{file.path}#{file.dir? ? '/' : ''} (extraneous)" if @verbose
    end

    def log_skip(file)
      puts "#{file.path}#{file.dir? ? '/' : ''} (skip)" if @verbose
    end

    private

    def _validate
      raise '--delete does not work without --recursive (-r) or --dirs (-d).' if @delete && !(@recursive || @dirs)
    end

    def _parse_size(options, option_name, default_value)
      opt = options.select { |o| o.start_with?(option_name) }.first
      return default_value if opt.nil?

      tokens = opt.split('=')
      raise "#{option_name} value is invalid: #{opt}" if tokens.size != 2
      actual_option_name = tokens[0].strip
      raise "#{option_name} value is invalid: #{opt}" if option_name != actual_option_name
      size_string = tokens[1].strip.downcase

      offset = 0
      if size_string.end_with?('+1')
        offset = 1
        size_string = size_string[0...size_string.size - 2]
      elsif size_string.end_with?('-1')
        offset = -1
        size_string = size_string[0...size_string.size - 2]
      end

      valid_suffix_map = {
        'k' => 1024,
        'kib' => 1024,
        'm' => 1024 * 1024,
        'mib' => 1024 * 1024,
        'g' => 1024 * 1024 * 1024,
        'gib' => 1024 * 1024 * 1024,
        'kb' => 1000,
        'mb' => 1000 * 1000,
        'gb' => 1000 * 1000 * 1000
      }

      order = 1
      valid_suffix_map.each do |suffix, o|
        next unless size_string.end_with?(suffix)

        size_string = size_string[0...(size_string.size - suffix.size)]
        order = o
        break
      end

      raise "#{option_name} value is invalid #{opt}" unless size_string.chars.select { |ch| !(('0'..'9').to_a + ['.']).include?(ch) }.empty?
      raise "#{option_name} value is invalid #{opt}" if size_string.empty? && order > 1

      base = 0
      unless size_string.empty?
        begin
          base = Float(size_string)
        rescue
          raise "#{option_name} value is invalid: #{opt}"
        end
      end

      base * order + offset
    end
  end
end
