require "test_helper"

class ApplicantTest < ActiveSupport::TestCase

  def applicant
    @applicant ||= Applicant.new
  end

  def test_valid
    assert applicant.valid?
  end

end
