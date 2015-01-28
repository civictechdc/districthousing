require "test_helper"

class HouseholdMemberTest < ActiveSupport::TestCase

  def household_member
    @household_member ||= HouseholdMember.new
  end

  def test_valid
    household_member.applicant = applicants(:one)
    assert household_member.valid?, household_member.errors.messages
  end

end
