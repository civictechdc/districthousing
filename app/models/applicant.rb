class Applicant < ActiveRecord::Base

  belongs_to :identity, :class_name => "Person", :foreign_key => "self_id"
  belongs_to :user

  delegate :dob,
    :first_name,
    :gender,
    :last_name,
    :middle_name,
    :res_apt,
    :res_city,
    :res_state,
    :res_street_address,
    :res_zip,
    :ssn,
    :phone,
    :work_phone,
    :home_phone,
    :cell_phone,
    :preferred_phone,
    :citizenship,
    :nationality,
    :email,
    :race,
    :student_status,
    :marital_status,
    :mail_city,
    :mail_state,
    :mail_street_address,
    :mail_zip,
    :dob_date,
    :age,
    to: :identity

  def preferred_attrs_for field_names
    field_names.map do |field_name|
      begin
        preferred_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def description
    identity.description
  end

  def field field_name
    case field_name
    when "FirstName"
      first_name
    when "LastName"
      last_name
    when /^(Full)?Name\d*/
      "#{first_name} #{middle_name} #{last_name}"
    when "DOB"
      dob_date
    when "Age"
      age
    when "SSN"
      ssn
    when "WorkPhone"
      work_phone
    when "CellPhone"
      cell_phone
    when "HomePhone"
      home_phone
    when "Phone"
      phone
    when "Email"
      email
    when "GenderInitial"
      gender[0]
    when "Gender"
      gender
    when "MailAddStreet"
      mail_street_address
    when "MailAddCity"
      mail_city
    when "MailAddState"
      mail_state
    when "MailAddZip"
      mail_zip
    when "PreferredPhone"
      preferred_phone
    when "WorkPhone"
      work_phone
    when "Nationality"
      nationality
    else
      ""
    end
  end
end
