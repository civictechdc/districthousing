class Applicant < ActiveRecord::Base

  belongs_to :identity, :class_name => "Person", :foreign_key => "self_id"
  belongs_to :user
  accepts_nested_attributes_for :identity
  attr_accessible :identity_attributes

  delegate :dob,
    :first_name,
    :gender,
    :last_name,
    :middle_name,
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
    :dob_date,
    :age,
    :residence,
    :mail,
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
    when "AddressStreet"
      residence.street
    when "AddressCity"
      residence.city
    when "AddressState"
      residence.state
    when "AddressZip"
      residence.zip
    when "Address"
      residence.full
    when "MailStreet"
      mail.street
    when "MailCity"
      mail.city
    when "MailState"
      mail.state
    when "MailZip"
      mail.zip
    when "Mail"
      mail.full
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
