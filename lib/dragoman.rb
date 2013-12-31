#!/usr/bin/env ruby

require 'ostruct'

class Dragoman

  class Rule
    attr_accessor :pattern, :productions

    def initialize pattern, productions
      @pattern = pattern
      @productions = productions
    end

    # FIXME: There might be different subsets of required items, if there is
    # more than one production.  Change this function's return value to express
    # that.
    def required_items
      productions.first.parameters.map { |param| param.last }
    end
  end

  attr_accessor :provider, :is_provided

  def initialize
    @rules = Array.new
    @provider = nil

    # The function to test whether the provider has a value for the source
    # field.  Defaults to a respond_to? check.  Users might want to set it
    # to an empty string check, for example.
    @is_provided = ->(source_field) { @provider.respond_to? source_field }
  end

  def learn pattern, *productions
    @rules << Rule.new(pattern, productions)
  end

  def required_items target
    matching_rule(target).required_items
  end

  def missing_items target
    required_items(target).reject { |param| @is_provided.call(param) }
  end

  def field target
    matching_rule(target).productions.each do |production|
      if is_usable production
        return invoke production
      end
    end
  end

  private

  def matching_rule target
    @rules.detect { |rule| rule.pattern =~ target }
  end

  def is_usable production
    production.parameters.all? { |param| @is_provided.call(param.last) }
  end

  def invoke production
    # FIXME: Replace the map with a required_items call
    # FIXME: Returns a lambda when no provider is set.  Why?
    arguments = production.parameters.map do |param|
      @provider.public_send(param.last)
    end
    return production.call(*arguments).to_s
  end

end
