require "test_helper"

class CriminalHistoryTest < ActiveSupport::TestCase

  def criminal_history
    @criminal_history ||= CriminalHistory.new
  end

  def test_valid
    assert criminal_history.valid?
  end

end
