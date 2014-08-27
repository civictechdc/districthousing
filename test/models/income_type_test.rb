require "test_helper"

class IncomeTypeTest < ActiveSupport::TestCase

  def income_type
    @income_type ||= IncomeType.new
  end

  def test_valid
    assert income_type.valid?
  end

end
