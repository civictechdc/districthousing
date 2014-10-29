class Person < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt
  attr_accessible :ssn
  attr_accessible :phone, :work_phone, :home_phone, :cell_phone, :preferred_phone
  attr_accessible :citizenship
  attr_accessible :nationality, :email, :race, :student_status, :marital_status
  attr_accessible :occupation

  belongs_to :mail_address, class_name: "Address"
  accepts_nested_attributes_for :mail_address
  attr_accessible :mail_address_attributes

  has_many :previous_ssns

  belongs_to :applicant

  validates :mail_address, presence: { message: "Mail address is missing" }
  validates_associated :mail_address

  def self.make_a_person
    create do |p|
      p.mail_address = Address.create
    end
  end

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
    when /^Address(.*)/
      mail_address && mail_address.value_for_field($1)
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
    when "PreferredPhone"
      cell_phone
    when "WorkPhone"
      work_phone
    when "Nationality"
      nationality
    when "MaritalStatus"
      marital_status
    when "StudentStatus"
      student_status
    when "Occupation"
      occupation
    else
      UnknownField.new
    end
  end

end
