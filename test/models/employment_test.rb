require "test_helper"

class EmploymentTest < ActiveSupport::TestCase

  def employment
    @employment ||= Employment.new
  end

  def test_valid
    assert employment.valid?
  end

end
