class Person < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt
  attr_accessible :ssn
  attr_accessible :phone, :work_phone, :home_phone, :cell_phone, :preferred_phone
  attr_accessible :citizenship
  attr_accessible :nationality, :email, :race, :student_status, :marital_status

  has_one :residence, dependent: :destroy
  accepts_nested_attributes_for :residence
  attr_accessible :residence_attributes

  has_one :mail_address, dependent: :destroy
  accepts_nested_attributes_for :mail_address
  attr_accessible :mail_address_attributes

  belongs_to :applicant

  has_many :previous_ssns

  belongs_to :user

  def description
    "#{first_name} #{last_name}"
  end

  def dob_date
    return "" if dob.nil?

    dob.strftime("%m/%d/%Y")
  end

  def age
    return "" if dob.nil?

    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}".strip.squeeze(" ")
  end

  def value_for_field field_name
    case field_name
    when "FirstName"
      first_name
    when "FirstInitial"
      first_name.first.upcase
    when "LastName"
      last_name
    when "LastInitial"
      last_name.first.upcase
    when "MiddleName"
      middle_name
    when "MiddleInitial"
      middle_name.first.upcase
    when /^(Full)?Name\d*/
      full_name
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
      gender && gender[0] || ""
    when "Gender"
      gender
    when "AddressStreet"
      residence && residence.street
    when "AddressCity"
      residence && residence.city
    when "AddressState"
      residence && residence.state
    when "AddressZip"
      residence && residence.zip
    when "Address"
      residence && residence.full
    when "MailStreet"
      mail_address && mail_address.street
    when "MailCity"
      mail_address && mail_address.city
    when "MailState"
      mail_address && mail_address.state
    when "MailZip"
      mail_address && mail_address.zip
    when "Mail"
      mail_address && mail_address.full
    when "PreferredPhone"
      cell_phone
    when "WorkPhone"
      work_phone
    when "Nationality"
      nationality
    when "MaritalStatus"
      marital_status
    when "Student"
      student_status
    else
      ""
    end
  end

end
