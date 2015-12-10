class CriminalHistory < ActiveRecord::Base
  include Progress
  include FindIndex

  def applicant
    person.applicant
  end

  part_of :criminal_histories
  belongs_to :person

  def to_s
    if crime_type.blank?
      "Crime (incomplete)"
    else
      if year.blank?
        "#{crime_type.humanize}"
      else
        "#{crime_type.humanize} in #{year}"
      end
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
