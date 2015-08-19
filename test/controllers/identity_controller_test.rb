require "test_helper"

class IdentityControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  def test_edit
    get :edit, applicant_id: applicants(:one)
    assert_response :success
  end

  def test_update
    person_update_hash = {
      first_name: "x",
      last_name: "x",
      middle_name: "x",
      dob: "2000-01-01",
      gender: "x",
      ssn: "x",
      work_phone: "x",
      home_phone: "x",
      cell_phone: "x",
      citizenship: "x",
      country_of_birth: "x",
      email: "x",
      race: "x",
      ethnicity: "x",
      student_status: "x",
      marital_status: "x",
      occupation: "x",
      state_of_birth: "x",
      city_of_birth: "x",
      driver_license_number: "x",
      driver_license_state: "x",
      driver_license_exp_date: "2000-01-01",
    }

    original_person = people(:one)
    put :update, applicant_id: applicants(:one), person: person_update_hash
    assert_attributes_were_updated original_person, person_update_hash.keys
    assert_redirected_to edit_identity_path(people(:one))
  end

end
