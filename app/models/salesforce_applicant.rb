class SalesforceApplicant < ActiveRecord::Base
  belongs_to :applicant
  validates :applicant, presence: true

  def merge intake
    if applicant.identity.nil?
      applicant.build_identity
    end
    applicant.identity.first_name = intake.FirstName__c
    applicant.identity.middle_name = intake.Middle_Name__c
    applicant.identity.last_name = intake.LastName__c
    if applicant.identity.mail_address.nil?
      applicant.identity.build_mail_address
    end
    applicant.identity.mail_address.street = intake.Address1__c
    applicant.identity.mail_address.city = intake.City__c
    applicant.identity.mail_address.state = intake.State__c
    applicant.identity.mail_address.zip = intake.ZipCode__c
  end
end
