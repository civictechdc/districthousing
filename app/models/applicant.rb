class Applicant < ActiveRecord::Base

  include Dragoman

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

  learn(/FirstName/, ->(first_name) { first_name })
  learn(/LastName/, ->(last_name) { last_name })
  learn(/FullName/, ->(first_name, middle_name, last_name) { "#{first_name} #{middle_name} #{last_name}" })
  learn(/DOB/, ->(dob) { dob })
  learn(/SSN/, ->(ssn) { ssn })
  learn(/Phone/, ->(phone) { phone })
  learn(/MailAddStreet/, ->(mail_street_address) { mail_street_address })
  learn(/MailAddCity/, ->(mail_city) { mail_city })
  learn(/MailAddState/, ->(mail_state) { mail_state })
  learn(/MailAddZip/, ->(mail_zip) { mail_zip })
  learn(/PreferredPhone/, ->(preferred_phone) { preferred_phone })
  learn(/WorkPhone/, ->(work_phone) { work_phone })
  learn(/RaceWhiChk/, ->(race) { race =~ /white/i and "Yes"  or "" })
  learn(/RaceIndChk/, ->(race) { race =~ /american indian/i and "Yes"  or "" })
  learn(/RaceIndChk/, ->(race) { race =~ /american indian/i and "Yes"  or "" })
  learn(/^HispChk/, ->(race) { race =~ /hispanic/i and "Yes"  or "" })
  learn(/NonHispChk/, ->(race) { race =~ /hispanic/i and ""  or "Yes" })
  learn(/RaceBlChk/, ->(race) { race =~ /black/i and "Yes"  or "" })
  learn(/RaceAsianChk/, ->(race) { race =~ /asian/i and "Yes"  or "" })
  learn(/NoAns/, ->(race) { race =~ /No answer/i and "Yes"  or "" })
end
