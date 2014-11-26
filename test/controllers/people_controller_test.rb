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
    person_update_hash = {
      first_name: "x",
      last_name: "x",
      middle_name: "x",
      dob: "2000-01-01",
      gender: "x",
      ssn: "x",
      phone: "x",
      work_phone: "x",
      home_phone: "x",
      cell_phone: "x",
      citizenship: "x",
      nationality: "x",
      email: "x",
      race: "x",
      student_status: "x",
      marital_status: "x",
      occupation: "x",
      state_of_birth: "x",
      city_of_birth: "x",
      driver_license_number: "x",
      driver_license_state: "x",
    }
    put :update, id: people(:one).id, person: person_update_hash

    assert_attributes_were_updated people(:one), person_update_hash.keys

    assert_redirected_to applicants(:one)
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
