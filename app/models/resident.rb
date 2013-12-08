class Resident < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt, :res_city, :res_state, :res_street_address, :res_zip, :ssn

  belongs_to :user

  def form_field_hash
    {
      FirstName: first_name,
      LastName: last_name,
      DOB: dob,
      SSN: ssn,
    }
  end

  def description
    "#{first_name} #{last_name}"
  end

end
