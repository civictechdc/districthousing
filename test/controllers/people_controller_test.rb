require "test_helper"

class PeopleControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_edit
    get :edit, id: people(:one).id
    assert_redirected_to new_user_session_path

    sign_in users(:one)
    session[:current_applicant_id] = 1
    get :edit, id: people(:one).id
    assert_response :success
  end

  def test_update
    sign_in users(:one)
    session[:current_applicant_id] = 1
    put :update, id: people(:one).id, person: { first_name: "NewName" }
    assert_redirected_to applicants(:one)
    assert_equal "NewName", Person.find(people(:one)).first_name
  end

  def test_destroy
    sign_in users(:one)
    session[:current_applicant_id] = 1
    assert_difference('Person.count', -1) do
      delete :destroy, id: people(:one)
    end

    assert_redirected_to applicant_path(applicants(:one))
  end

end
