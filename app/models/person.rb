class Person < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt
  attr_accessible :ssn
  attr_accessible :phone, :work_phone, :home_phone, :cell_phone, :preferred_phone
  attr_accessible :citizenship
  attr_accessible :nationality, :email, :race, :student_status, :marital_status

  belongs_to :residence, class_name: "Address"
  belongs_to :mail, class_name: "Address"

  has_many :previous_ssns

  belongs_to :user

  def description
    "#{first_name} #{last_name}"
  end

  def dob_date
    dob.strftime("%m/%d/%Y")
  end

  def age
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end
