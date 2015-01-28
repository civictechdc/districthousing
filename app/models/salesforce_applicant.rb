class SalesforceApplicant < ActiveRecord::Base
  belongs_to :applicant
  validates :applicant, presence: true

  @@identity_mappings = {
    first_name: :FirstName__c,
    middle_name: :Middle_Name__c,
    last_name: :LastName__c,
    dob: :DOB__c,
    ssn: :SSN__c,
    cell_phone: :PrimaryPhoneNo__c,
    home_phone: :AlternatePhoneNo__c,
    email: :Primary_Email__c,
    gender: :Gender__c,
    race: :Race__c,
  }

  @@identity_mail_address_mappings = {
    street: :Address1__c,
    city: :City__c,
    state: :State__c,
    zip: :ZipCode__c,
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
