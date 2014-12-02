class CriminalHistory < ActiveRecord::Base
  belongs_to :crime_type
  belongs_to :person

  def to_s
    "#{crime_type.label} in #{year.year}"
  end
end
