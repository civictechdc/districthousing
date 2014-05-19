require 'test_helper'

class FormPickerControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  test "should get index" do
    sign_in User.first
    get :index
    assert_response :success
    assert_not_nil assigns[:applicant]

    assert_not_equal [], assigns[:pdf_field_names]
    assert_not_equal nil, assigns[:applicant]
    assert_equal "One", assigns[:applicant].identity.first_name
  end

  test "should download forms" do
    get :download
    assert_response :redirect
  end
end
