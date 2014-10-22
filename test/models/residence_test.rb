require "test_helper"

class ResidenceTest < ActiveSupport::TestCase

  def residence
    @residence ||= residences :one
  end

  def test_valid
    assert residence.valid?, residence.errors.messages
  end

end
