class SalesforceApplicant < ActiveRecord::Base
  belongs_to :applicant
  validates :applicant, presence: true

  @@identity_mappings = {
    first_name: :First_Name__c,
    middle_name: :Middle_Name__c,
    last_name: :Last_Name__c,
    dob: :DOB__c,
    state_of_birth: :State_of_Birth__c,
    city_of_birth: :City_of_Birth__c,
    ssn: :SSN__c,
    cell_phone: :Primary_Phone__c, # FIXME: type of phone determined by Primary_Phone_Type__c
    home_phone: :Primary_Phone__c,
    email: :Email_Address__c,
    driver_license_number: :Drivers_License_Number__c,
    driver_license_state: :Drivers_License_State__c,
    gender: :Gender__c,
    race: :Race__c,
    citizenship: :Immigrant__c,
    student_status: :Student_Status__c,
    marital_status: :Marital_Status__c,
    occupation: :Occupation__c,
    ethnicity: :Hispanic__c
  }

  @@identity_mail_address_mappings = {
    street: :Primary_Address_1__c,
    city: :Primary_City__c,
    state: :Primary_State__c,
    zip: :Primary_Zip_Code__c,
  }

  def merge_model(mappings, identity, intake)
    mappings.each do |k,v|
      target = intake.send(v)
      identity.send("#{k}=", target) unless target.blank?
    end
  end

  def merge intake
    if applicant.identity.nil?
      applicant.build_identity
    end
    merge_model(@@identity_mappings, applicant.identity, intake)

    if applicant.identity.mail_address.nil?
      applicant.identity.build_mail_address
    end
    merge_model(@@identity_mail_address_mappings, applicant.identity.mail_address, intake)
  end
end
