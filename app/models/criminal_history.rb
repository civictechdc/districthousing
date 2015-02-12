class CriminalHistory < ActiveRecord::Base
  include Progress
  include FindIndex

  def applicant
    person.applicant
  end

  part_of :criminal_histories
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
