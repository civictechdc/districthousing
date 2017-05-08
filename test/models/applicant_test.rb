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

  def test_residences_are_sorted_with_current_first
    a = applicants :one
    r1 = residences :one
    r2 = residences :two

    r1.current = true
    r1.save
    assert_equal '1 Residence Lane', a.residences.first.address.street
    r1.current = false
    r1.save

    r2.current = true
    r2.save
    assert_equal '2 Residence Grove', a.residences.first.address.street
  end

end
