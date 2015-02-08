require "test_helper"

class SalesforceApplicantTest < ActiveSupport::TestCase

  def salesforce_applicant
    @salesforce_applicant ||= SalesforceApplicant.new do |sfa|
      sfa.applicant = applicants :empty
    end
  end

  def test_valid
    assert salesforce_applicant.valid?, salesforce_applicant.errors.messages
  end

  def test_merge
    intake = FakeIntake.new(
      Name: "one",
      First_Name__c: "First",
      Middle_Name__c: "Middle",
      Last_Name__c: "Last",
      Primary_Address_1__c: "123 Fake St",
      Primary_City__c: "Washington",
      Primary_State__c: "DC",
      Primary_Zip_Code__c: "12345",
      DOB__c: "1959-02-17",
      SSN__c: "123-45-6789",
      Primary_Phone__c: "1234567",
      Email_Address__c: "foo@bar.baz",
      Gender__c: "Female",
      Race__c: "Pacific Islander",
      State_of_Birth__c: "New Hampshire",
      City_of_Birth__c: "San Francisco",
      Drivers_License_Number__c: "T12-3456",
      Drivers_License_State__c: "VA",
      Immigrant__c: "Sealand",
      Student_Status__c: "Student",
      Marital_Status__c: "Married",
      Occupation__c: "Cobbler",
      Hispanic__c: "Hispanic",
    )

    salesforce_applicant.merge intake

    identity = salesforce_applicant.applicant.identity

    assert_equal "First", identity.first_name
    assert_equal "Middle", identity.middle_name
    assert_equal "Last", identity.last_name
    assert_equal Date.new(1959,02,17), identity.dob
    assert_equal "123-45-6789", identity.ssn
    assert_equal "1234567", identity.cell_phone
    assert_equal "1234567", identity.home_phone
    assert_equal "foo@bar.baz", identity.email
    assert_equal "Pacific Islander", identity.race

    assert_equal "123 Fake St", identity.mail_address.street
    assert_equal "Washington", identity.mail_address.city
    assert_equal "DC", identity.mail_address.state
    assert_equal "12345", identity.mail_address.zip

    assert_equal "New Hampshire", identity.state_of_birth
    assert_equal "San Francisco", identity.city_of_birth
    assert_equal "T12-3456", identity.driver_license_number
    assert_equal "VA", identity.driver_license_state
    assert_equal "Sealand", identity.citizenship
    assert_equal "Student", identity.student_status
    assert_equal "Married", identity.marital_status
    assert_equal "Cobbler", identity.occupation
    assert_equal "Hispanic", identity.ethnicity

    # Updates in Salesforce should overwrite existing fields, unless they are
    # blank
    changed_intake = FakeIntake.new(
      Name: "one",
      First_Name__c: "New first name",
      Last_Name__c: "",
    )

    salesforce_applicant.merge changed_intake

    identity = salesforce_applicant.applicant.identity

    assert_equal "New first name", identity.first_name
    assert_equal "Last", identity.last_name
  end
end
