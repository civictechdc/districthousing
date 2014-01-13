require 'test_helper'

class FormPickerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, {}, {'cart_id' => '1'}
    assert_response :success
    assert_not_nil assigns[:cart]
    assert_not_nil assigns[:current_form_ids]
    assert_not_nil assigns[:housing_forms]

    assert_not_equal nil, assigns[:cart].resident
    assert_equal "Test", assigns[:cart].resident.first_name
  end

  test "should download forms" do
    get :download
    assert_response :success
  end
end
