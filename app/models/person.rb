class Person < ActiveRecord::Base
  include Progress

  progress_includes :mail_address

  belongs_to :mail_address, class_name: "Address"
  accepts_nested_attributes_for :mail_address

  has_many :incomes
  has_many :employments
  has_many :criminal_histories
  has_many :previous_ssns

  belongs_to :applicant

  before_validation :initialize_person
  validates_associated :mail_address
  validates :mail_address, :dob, presence: true
  validate :validate_dob_year

  def initialize_person
    self.mail_address ||= Address.new
  end

  def description
    "#{first_name} #{last_name}"
  end

  def to_s
    description
  end

  def dob_date
    return "" if dob.nil?

    dob.strftime("%m/%d/%Y")
  end

  def validate_dob_year
    if dob != nil && dob < (Date.today - 43800)
      errors.add(:dob, "Date of birth is too long ago")
    end
  end

  def dob_dd
    return "" if dob.nil?
    dob.strftime("%d")
  end

  def dob_mm
    return "" if dob.nil?
    dob.strftime("%m")
  end

  def dob_yyyy
    return "" if dob.nil?
    dob.strftime("%Y")
  end

  def age
    return "" if dob.nil?

    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}".strip.squeeze(" ")
  end

  def us_citizen?
    # FIXME: Instead of using regexes for this, country of citizenship should
    # be normalized
    return /^(United States|US|USA|U.S.A.)$/i =~ citizenship
  end

  def preferred_phone
    # FIXME: Make preferred phone selectable
    [cell_phone, home_phone, work_phone].reject{|p| p.blank?}.first
  end

  def married?
    marital_status == "Married"
  end

  def student?
    student_status == "Full-time" or student_status == "Part-time"
  end

  def student_full_time?
    student_status == "Full-time"
  end

  def value_for_field field_name
    case field_name
    when /^Mail(.*)/
      mail_address && mail_address.value_for_field($1)
    when "FirstName"
      first_name
    when "FirstInitial"
      first_name.to_s.first.upcase
    when "LastName"
      last_name
    when "LastInitial"
      last_name.to_s.first.upcase
    when "MiddleName"
      middle_name
    when "MiddleInitial"
      middle_name.to_s.first.upcase
    when /^(Full)?Name\d*/
      full_name
    when "DOB"
      dob_date
    when "DOBDD"
      dob_dd
    when "DOBMM"
      dob_mm
    when "DOBYYYY"
      dob_yyyy
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
      preferred_phone
    when "Email"
      email
    when "GenderInitial"
      gender.to_s.first
    when "Gender"
      gender
    when "Race"
      race
    when "Ethnicity"
      ethnicity
    when "PreferredPhone"
      cell_phone
    when "WorkPhone"
      work_phone
    when "CountryOfBirth"
      country_of_birth
    when "MaritalStatus"
      marital_status
    when "StudentStatus"
      student_status
    when "Occupation"
      occupation
    when "BirthState"
      state_of_birth
    when "BirthCity"
      city_of_birth
    when "USCitizenYN"
      if us_citizen?
        "Y"
      else
        "N"
      end
    when "USCitizenYesNo"
      if us_citizen?
        "Yes"
      else
        "No"
      end
    when "DriverLicense"
      driver_license_number
    when "DriverLicenseState"
      driver_license_state
    when "Relationship"
      "Self"
    when "MarriedYesNo"
      if married?
        "Yes"
      else
        "No"
      end
    when "MarriedYN"
      if married?
        "Y"
      else
        "N"
      end
    when "StudentStatusYesNo"
      if student?
        "Yes"
      else
        "No"
      end
    when "StudentStatusYN"
      if student?
        "Y"
      else
        "N"
      end
    when "StudentStatusFullTimeYesNo"
      if student_full_time?
        "Yes"
      else
        "No"
      end
    when "StudentStatusFullTimeYN"
      if student_full_time?
        "Y"
      else
        "N"
      end
    else
      UnknownField.new
    end
  end

end
