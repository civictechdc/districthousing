require "test_helper"

class ResidenceTest < ActiveSupport::TestCase

  def residence
    @residence ||= Residence.new
  end

  def test_valid
    assert residence.valid?, residence.errors.messages
  end

  test 'should display homeless instead of residence if address is homeless or none' do 
    addr = addresses :homeless
    assert_equal addr.full, 'Homeless'

    # tests 'currently homeless'
    residence = Residence.new address_id: addr.id, current: true
    assert_equal "Currently homeless", residence.to_s

    # tests 'homeless'
    residence.current = false
    assert_equal "Homeless", residence.to_s

    # tests 'Current residence at'
    addr_1 = addresses :one
    residence_1 = Residence.new address_id: addr_1.id, current: true
    assert_equal "Current residence at 111 Fake Street, Oneville, DC, 11111", residence_1.to_s

    # tests noncurrent residence at
    residence_1.current = false
    assert_equal "Residence at 111 Fake Street, Oneville, DC, 11111", residence_1.to_s
  end
end
