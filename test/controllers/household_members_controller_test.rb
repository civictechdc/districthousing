require "test_helper"

class HouseholdMembersControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  def test_new
    assert_difference('HouseholdMember.count') do
      get :new, applicant_id: applicants(:one)
    end
    assert_redirected_to edit_applicant_household_member_path(applicants(:one), assigns[:model])
  end

  def test_update
    sign_in users(:one)
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
      driver_license_exp_date: "x",
    }
    household_member_update_hash = {
      person_attributes: person_update_hash,
      relationship: "x"
    }

    put :update, applicant_id: applicants(:one), id: household_members(:three), household_member: household_member_update_hash

    assert_equal("x", HouseholdMember.find(household_members(:three).id).relationship)

    assert_redirected_to edit_applicant_household_member_path(applicants(:one), household_members(:three))
  end

  def test_edit
    get :edit, applicant_id: applicants(:one), id: household_members(:three)
    assert_response :success
  end

  def test_edit_empty
    get :front, applicant_id: applicants(:empty)
    assert_response :success
  end

  def test_destroy
    assert_difference('HouseholdMember.count', -1) do
      get :destroy, applicant_id: applicants(:one), id: household_members(:three)
    end
    assert_redirected_to applicants(:one)
  end

end
