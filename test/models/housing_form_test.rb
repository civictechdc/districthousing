require "test_helper"

class HousingFormTest < ActiveSupport::TestCase

  def housing_form
    @housing_form ||= HousingForm.new
  end

  def test_valid
    assert housing_form.valid?
  end

end
