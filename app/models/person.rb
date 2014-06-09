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
end
