require "test_helper"

class CrimeTypeTest < ActiveSupport::TestCase

  def crime_type
    @crime_type ||= CrimeType.new
  end

  def test_valid
    assert crime_type.valid?
  end

end
