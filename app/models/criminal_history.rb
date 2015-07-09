class CriminalHistory < ActiveRecord::Base
  include Progress
  include FindIndex

  def applicant
    person.applicant
  end

  part_of :criminal_histories
  belongs_to :person

  def to_s
    unless year.nil?
      "#{crime_type.humanize} in #{year}"
    else
      "#{crime_type.humanize}"
    end
  end

  def value_for_field field_name
    case field_name
    when "Date"
      year
    when "Type"
      Constants::CrimeType.new(crime_type).name_pdf
    when "Description"
      description
    when /^(\D+)$/
      person.value_for_field $1
    else
      UnknownField.new
    end
  end

end
