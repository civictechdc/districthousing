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
      when /Yes/
        "Yes"
      when /Y|T/
        "Y"
      else
        ""
      end
    else
      case boolean_field_component
      when /No/
        "No"
      when /N|F/
        "N"
      else
        ""
      end
    end
  end
end
