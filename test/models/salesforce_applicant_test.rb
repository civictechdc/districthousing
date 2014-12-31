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
      Middle_Name__c: "Middle",
      LastName__c: "Last",
      Address1__c: "123 Fake St",
      City__c: "Washington",
      State__c: "DC",
      ZipCode__c: "12345"
    )

    salesforce_applicant.merge intake

    identity = salesforce_applicant.applicant.identity

    assert_equal identity.first_name, "First"
    assert_equal identity.middle_name, "Middle"
    assert_equal identity.last_name, "Last"

    assert_equal identity.mail_address.street, "123 Fake St"
    assert_equal identity.mail_address.city, "Washington"
    assert_equal identity.mail_address.state, "DC"
    assert_equal identity.mail_address.zip, "12345"
  end
end
