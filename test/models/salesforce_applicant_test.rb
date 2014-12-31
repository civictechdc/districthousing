require "test_helper"

class SalesforceApplicantTest < ActiveSupport::TestCase

  def salesforce_applicant
    @salesforce_applicant ||= SalesforceApplicant.new do |sfa|
      sfa.applicant = applicants :one
    end
  end

  def test_valid
    assert salesforce_applicant.valid?, salesforce_applicant.errors.messages
  end

  def test_merge
    intake = FakeIntake.new(
      Name: "123456",
      FirstName__c: "First",
      LastName__c: "Last"
    )

    salesforce_applicant.merge intake

    assert_equal salesforce_applicant.applicant.identity.first_name, "First"
    assert_equal salesforce_applicant.applicant.identity.last_name, "Last"
  end
end
