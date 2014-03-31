class Resident < ActiveRecord::Base
  attr_accessible :first_name, :gender, :last_name, :middle_name, :res_apt
  attr_accessible :res_city, :res_state, :res_street_address, :res_zip, :ssn
  attr_accessible :phone, :work_phone, :home_phone, :cell_phone, :preferred_phone
  attr_accessible :citizenship
  attr_accessible :nationality, :email, :race, :student_status, :marital_status
  attr_accessible :mail_city, :mail_state, :mail_street_address, :mail_zip

  has_many :previous_ssns

  belongs_to :user
  has_many :carts

  def description
    "#{first_name} #{last_name}"
  end

  def missing_attrs_for field_names
    field_names.map do |field_name|
      begin
        $field_name_translator.missing_items field_name, self
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def unrecognized_fields_for field_names
    field_names.map do |field_name|
      begin
        $field_name_translator.required_items field_name
        nil
      rescue Dragoman::NoMatchError
        field_name
      end
    end.flatten.reject(&:nil?).to_set
  end

  def preferred_attrs_for field_names
    field_names.map do |field_name|
      begin
        $field_name_translator.preferred_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def dob
    attributes["dob"].strftime("%m/%d/%Y")
  end

end
