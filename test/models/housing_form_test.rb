require "test_helper"

class HousingFormTest < ActiveSupport::TestCase

  def setup
    # Prevent external geocoding API calls.
    HousingForm.any_instance.stubs(:geocode)
  end

  def housing_form
    @housing_form ||= HousingForm.new
  end

  def test_valid
    assert housing_form.valid?
  end

end
