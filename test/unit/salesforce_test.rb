class SalesforceApplicantTest < ActiveSupport::TestCase
  test "mirrors records in salesforce" do
    assert_equal 3, Applicant.count
    #SalesforceApplicant.pull_from_salesforce
  end
end
