class Address < ActiveRecord::Base
  include Progress

  belongs_to :applicant

  def apartment
    case apt
    when /^\d+[[:alpha:]]?$/ # For a string of digits without "Apartment" or "Unit" in the prefix
      "##{apt}"
    when /^\w$/ # For single letter apartment numbers
      "##{apt}"
    else # Otherwise, just use whatever they put
      apt
    end
  end

  def full
    if homeless?
      "Homeless"
    elsif street.to_s.empty? or city.to_s.empty?
      ""
    else
    "#{street}, #{apartment}, #{city}, #{state}, #{zip}".gsub(/( ,)+/, "").strip.sub(/,$/, "")
    end
  end

  def to_s
    full
  end

  def value_for_field field_name
    case field_name
    when "Street"
      street
    when "City"
      city
    when "State"
      state
    when "Zip"
      zip
    when "Apt"
      apartment
    when ""
      full
    else
      UnknownField.new
    end
  end

  def homeless?
    /homeless/i.match street.to_s 
  end
end
