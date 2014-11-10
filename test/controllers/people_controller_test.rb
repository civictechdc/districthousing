require "test_helper"

class PeopleControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_edit
    get :edit, id: people(:one).id
    assert_redirected_to new_user_session_path

    sign_in users(:one)
    get :edit, id: people(:one).id
    assert_response :success
  end

  def test_update
    flunk "test me"
  end

  def test_destroy
    flunk "test me"
  end

end
