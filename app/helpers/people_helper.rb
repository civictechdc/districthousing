module PeopleHelper

  def hidden_attributes
    %w(created_at updated_at applicant_id id)
  end

  def column_1_attributes
    %w(first_name middle_name last_name dob state_of_birth city_of_birth ssn)
  end

  def column_2_attributes
    %w(home_phone cell_phone work_phone email driver_license_number driver_license_state mail_address_id)
  end

  def column_3_attributes
    Person.attribute_names.reject do |a|
      column_1_attributes.include?(a) or column_2_attributes.include?(a) or hidden_attributes.include?(a)
    end
  end

  def attribute_as_label attribute_name
    case attribute_name
    when 'mail_address_id'
      "Address"
    when 'dob'
      "Date of birth"
    else
      attribute_name.humanize
    end
  end

  def display_value_for_attribute person, attribute_name
    case attribute_name
    when 'mail_address_id'
      person.mail_address.full
    when 'dob'
      person.dob_date
    else
      person[attribute_name]
    end
  end
end
