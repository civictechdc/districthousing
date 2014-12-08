class CriminalHistory < ActiveRecord::Base
  include Progress

  belongs_to :crime_type
  belongs_to :person

  def to_s
    unless year.nil?
      "#{crime_type.label} in #{year.year}"
    else
      "#{crime_type.label}"
    end
  end
end
