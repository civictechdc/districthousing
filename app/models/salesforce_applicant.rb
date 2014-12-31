class SalesforceApplicant < ActiveRecord::Base
  belongs_to :applicant
  validates :applicant, presence: true

  def merge intake
    applicant.identity = Person.new
    applicant.identity.first_name = intake.FirstName__c
    applicant.identity.last_name = intake.LastName__c
  end
end
