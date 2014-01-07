require 'test_helper'

class FormPickerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should download forms" do
    get :download
    assert_response :success
  end
end
