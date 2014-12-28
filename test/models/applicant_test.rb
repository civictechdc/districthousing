require "test_helper"

class ApplicantTest < ActiveSupport::TestCase

  def applicant
    @applicant ||= Applicant.new do |a|
      a.user = users :one
    end
  end

  def test_valid
    assert applicant.valid?, applicant.errors.messages
  end

end
