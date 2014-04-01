class Applicant < ActiveRecord::Base
  belongs_to :identity, :class_name => "Person", :foreign_key => "self_id"

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
    to: :identity

  def preferred_attrs_for field_names
    field_names.map do |field_name|
      begin
        $field_name_translator.preferred_items field_name
      rescue Dragoman::NoMatchError
        nil
      end
    end.flatten.reject(&:nil?).to_set
  end

  def description
    identity.description
  end

end
