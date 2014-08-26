require "test_helper"

class IncomeTest < ActiveSupport::TestCase

  def income
    @income ||= Income.new
  end

  def test_valid
    assert income.valid?
  end

end
