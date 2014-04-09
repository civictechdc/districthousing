#!/usr/bin/env ruby

require 'set'

class Dragoman

  def self.is_provided(provider, source_field)
    provider.respond_to? source_field and not provider.public_send(source_field).to_s.empty?
  end

  # Indicates that the user requested a field, but the provider doesn't contain
  # the necessary information to produce the result.  User code might want to
  # prompt for more information in the provider.
  class MissingItemsError < StandardError
    attr_reader :missing_items

    def initialize missing
      @missing_items = missing
    end
  end

  # The Dragoman was asked about a particular field, but it doesn't have any
  # rules that match the field name.
  class NoMatchError < StandardError; end

  class Rule
    attr_reader :pattern, :productions

    def initialize pattern, productions
      @pattern = pattern
      @productions = productions
    end

    def preferred_items
      parameter_names @productions.first
    end

    def required_items
      parameter_names @productions.last
    end

    def missing_items provider
      required_items.reject { |param| Dragoman.is_provided(provider, param) }
    end

    def produce provider
      @productions.each do |production|
        if usable? production, provider
          return invoke production, provider
        end
      end

      raise MissingItemsError.new(missing_items(provider))
    end

    def invoke production, provider
      # FIXME: Returns a lambda when no provider is set.  Why?
      arguments = parameter_names(production).map do |param|
        provider.public_send(param)
      end
      return production.call(*arguments).to_s
    end

    def usable? production, provider
      parameter_names(production).all? { |param| Dragoman.is_provided(provider, param) }
    end

    private

    def parameter_names production
      production.parameters.map { |param| param.last }
    end
  end

  attr_accessor :provider

  def initialize
    @rules = Array.new
    yield self if block_given?
  end

  def learn pattern, *productions
    @rules << Rule.new(pattern, productions)
  end

  def preferred_items target
    matching_rule(target).preferred_items
  end

  def required_items target
    matching_rule(target).required_items
  end

  def missing_items target, provider
    matching_rule(target).missing_items(provider)
  end

  def field target, provider
    matching_rule(target).produce(provider)
  end

  private

  def matching_rule target
    @rules.detect { |rule| rule.pattern =~ target } or raise NoMatchError, "Unrecognized field \"#{target}\""
  end

end
