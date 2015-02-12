class Employment < ActiveRecord::Base
  include Progress
  include FindIndex

  def applicant
    person.applicant
  end

  part_of :employments
  progress_includes :address

  belongs_to :person
  belongs_to :address
  accepts_nested_attributes_for :address

  def delegate_field_to item, field_name
    item && item.value_for_field(field_name) || ""
  end

  def end_or_current
    if current
      "current"
    else
      end_date
    end
  end

  def to_s
    if current
      "Current employment at #{employer_name} from #{start_date}"
    else
      "Employment at #{employer_name} from #{start_date} to #{end_date}"
    end
  end

  ## NEED TO FIGURE OUT HOW STATUS IS DEFINED

  def value_for_field field_name
    case field_name
    #when "Status"
    when "Title"
      position
    when "StartDate"
      start_date
    when "EndDate"
      end_date
    when "Employer"
      employer_name
    when "Phone"
      phone
    when /^(\D+)$/
      unless ['Status','Title','StartDate','EndDate','Employer','Phone'].include?($1)
        delegate_field_to address, $1
      end
    end
  end
end
