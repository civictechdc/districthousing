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

end
