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

  def value_for_field field_name
    case field_name
    when "Date"
      year
    when "DateYYYY"
      year.year
    when "DateMM"
      year.month
    when "DateDD"
      year.day
    when "Type"
      crime_type.label
    when "Description"
      description
    when /^(\D+)$/
      person.value_for_field $1
    else
      UnknownField.new
    end
  end

end
