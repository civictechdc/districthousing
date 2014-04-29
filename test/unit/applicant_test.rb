require 'test_helper'

class ApplicantTest < ActiveSupport::TestCase
  def setup
    @one = applicants(:one)
    @two = applicants(:two)
  end

  test "responds to form field values" do
    assert_equal "One John McOne", @one.field("FullName")
    assert_equal "One John McOne", @one.field("FullName1")
  end
end
