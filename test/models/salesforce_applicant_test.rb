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
      Name: "one",
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

    assert_equal "First", identity.first_name
    assert_equal "Middle", identity.middle_name
    assert_equal "Last", identity.last_name

    assert_equal "123 Fake St", identity.mail_address.street
    assert_equal "Washington", identity.mail_address.city
    assert_equal "DC", identity.mail_address.state
    assert_equal "12345", identity.mail_address.zip

    # Updates in Salesforce should overwrite existing fields, unless they are
    # blank
    changed_intake = FakeIntake.new(
      Name: "one",
      FirstName__c: "New first name",
      LastName__c: "",
    )

    salesforce_applicant.merge changed_intake

    identity = salesforce_applicant.applicant.identity

    assert_equal "New first name", identity.first_name
    assert_equal "Last", identity.last_name
  end
end
