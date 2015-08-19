class Person < ActiveRecord::Base
  include Progress
  include BooleanFields

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
  validates :mail_address, presence: true
  validate :validate_dob_year

  def initialize_person
    self.mail_address ||= Address.new
  end

  def description
    if first_name.blank? and last_name.blank?
      "(No name)"
    else
      "#{first_name} #{last_name}"
    end
  end

  def to_s
    description
  end

  def dob_date
    return "" if dob.nil?

    dob.strftime("%m/%d/%Y")
  end

  def validate_dob_year
    errors.add(:dob, "Date of birth is too long ago.") if dob != nil && dob < (Date.today - 43800)
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

  def driver_license_exp_date_full
    return "" if driver_license_exp_date.nil?
    driver_license_exp_date.strftime("%m/%d/%Y")
  end


  def driver_license_exp_date_dd
    return "" if driver_license_exp_date.nil?
    driver_license_exp_date.strftime("%d")
  end

  def driver_license_exp_date_mm
    return "" if driver_license_exp_date.nil?
    driver_license_exp_date.strftime("%m")
  end

  def driver_license_exp_date_yyyy
    return "" if driver_license_exp_date.nil?
    driver_license_exp_date.strftime("%Y")
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
    return "US Citizen" == citizenship
  end

  def preferred_phone
    # FIXME: Make preferred phone selectable
    [cell_phone, home_phone, work_phone].reject{|p| p.blank?}.first
  end

  def married?
    marital_status == "Married"
  end

  def single?
    marital_status == "Single"
  end

  def divorced?
    marital_status == "Divorced"
  end

  def separated?
    marital_status == "Separated"
  end

  def widowed?
    marital_status == "Widowed"
  end

  def student?
    student_status == "Full-time" or student_status == "Part-time"
  end

  def student_full_time?
    student_status == "Full-time"
  end

  def male?
    gender == "Male"
  end

  def female?
    gender == "Female"
  end

  def value_for_field field_name
    case field_name
    when /^Mail(.*)/
      mail_address && mail_address.value_for_field($1)
    when /^Address(.*)/
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
    when /^(Full)?Name\d*$/
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
    when /^(Preferred)?Phone$/
      preferred_phone
    when "Email"
      email
    when "GenderInitial"
      gender.to_s.first
    when "Gender"
      gender
    when "Race"
      Constants::Race.new(race).name_pdf
    when /RaceAsian(#{boolean_regex})/
      boolean_field $1 do race == "Asian" end
    when /RaceBlack(#{boolean_regex})/
      boolean_field $1 do race == "Black" end
    when /RaceNativeAmerican(#{boolean_regex})/
      boolean_field $1 do race == "NativeAmerican" end
    when /RaceOther(#{boolean_regex})/
      boolean_field $1 do race == "Other" end
    when /RacePacificIslander(#{boolean_regex})/
      boolean_field $1 do race == "PacificIslander" end
    when /RaceWhite(#{boolean_regex})/
      boolean_field $1 do race == "White" end
    when /RaceDecline(#{boolean_regex})/
      boolean_field $1 do race == "Decline" end
    when "Ethnicity"
      Constants::Ethnicity.new(ethnicity).name_pdf
    when /EthnicityHispanic(#{boolean_regex})/
      boolean_field $1 do ethnicity == "Hispanic" end
    when /EthnicityNotHispanic(#{boolean_regex})/
      boolean_field $1 do ethnicity == "NotHispanic" end
    when /EthnicityDecline(#{boolean_regex})/
      boolean_field $1 do ethnicity == "Decline" end
    when "CountryOfBirth"
      country_of_birth
    when "BirthState"
      state_of_birth
    when "BirthCity"
      city_of_birth
    when "MaritalStatus"
      marital_status
    when "StudentStatus"
      student_status
    when "Occupation"
      occupation
    when "Citizenship"
      citizenship
    when "Nationality"
      citizenship # Synonymous with Citizenship
    when /USCitizen(#{boolean_regex})/
      boolean_field $1 do us_citizen? end
    when "DriverLicense"
      driver_license_number
    when "DriverLicenseState"
      driver_license_state
    when "DriverLicenseExpire"
      driver_license_exp_date_full
    when "DriverLicenseExpireDD"
      driver_license_exp_date_dd
    when "DriverLicenseExpireMM"
      driver_license_exp_date_mm
    when "DriverLicenseExpireYYYY"
      driver_license_exp_date_yyyy
    when "Relationship"
      "Self"
    when /Married(#{boolean_regex})/
      boolean_field $1 do married? end
    when /Separated(#{boolean_regex})/
      boolean_field $1 do separated? end
    when /Single(#{boolean_regex})/
      boolean_field $1 do single? end
    when /Divorced(#{boolean_regex})/
      boolean_field $1 do divorced? end
    when /Widowed(#{boolean_regex})/
      boolean_field $1 do widowed? end
    when /StudentStatus(#{boolean_regex})/
      boolean_field $1 do student? end
    when /StudentStatusFullTime(#{boolean_regex})/
      boolean_field $1 do student_full_time? end
    when /GenderMale(#{boolean_regex})/
      boolean_field $1 do male? end
    when /GenderFemale(#{boolean_regex})/
      boolean_field $1 do female? end
    else
      UnknownField.new
    end
  end
end

