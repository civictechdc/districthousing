class SalesforceApplicant < ActiveRecord::Base
  belongs_to :applicant
  validates :applicant, presence: true

  def merge intake
    if applicant.identity.nil?
      applicant.build_identity
    end
    applicant.identity.first_name = intake.FirstName__c unless intake.FirstName__c.blank?
    applicant.identity.middle_name = intake.Middle_Name__c unless intake.Middle_Name__c.blank?
    applicant.identity.last_name = intake.LastName__c unless intake.LastName__c.blank?

    if applicant.identity.mail_address.nil?
      applicant.identity.build_mail_address
    end
    applicant.identity.mail_address.street = intake.Address1__c unless intake.Address1__c.blank?
    applicant.identity.mail_address.city = intake.City__c unless intake.City__c.blank?
    applicant.identity.mail_address.state = intake.State__c unless intake.State__c.blank?
    applicant.identity.mail_address.zip = intake.ZipCode__c unless intake.ZipCode__c.blank?
  end
end
