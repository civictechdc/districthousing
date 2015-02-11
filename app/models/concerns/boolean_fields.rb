# This module lets models fill Yes/No fields more succinctly.
#
# Invoke like this:
#
# when /Married(#{boolean_regex})/
#   boolean_field $1 do married? end
#
# This will support all boolean forms of Married:
#
# - MarriedYesNo,
# - MarriedYes,
# - MarriedNo,
# - MarriedYN,
# - MarriedY,
# - MarriedN,
# - MarriedTickYes,
# - MarriedTickNo,

module BooleanFields

  extend ActiveSupport::Concern

  def boolean_regex
    "(Yes|No|Y|N|T|F|TickYes|TickNo)+$"
  end

  def boolean_field boolean_field_component
    truth = yield
    if truth
      case boolean_field_component
      when /^(Tick)?Yes(No)?$|^T$/
        "Yes"
      when /^Y$|^YN$/
        "Y"
      else
        ""
      end
    else
      case boolean_field_component
      when /^TickNo$/
        "Yes"
      when /^(Yes)?No$/
        "No"
      when /^N$|^YN$/
        "N"
      else
        ""
      end
    end
  end
end
