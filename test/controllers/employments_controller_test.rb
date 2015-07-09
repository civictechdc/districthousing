require "test_helper"

class EmploymentsControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  def employment
    @employment ||= employments :one
  end

  def test_new
    assert_difference('Employment.count') do
      get :new, applicant_id: applicants(:one)
    end

    assert_redirected_to edit_applicant_employment_path(applicants(:one), assigns(:model))
  end

  def test_edit
    get :edit, applicant_id: applicants(:one), id: employments(:one)
    assert_response :success
  end

  def test_edit_empty
    get :front, applicant_id: applicants(:empty)
    assert_response :success
  end

  def test_destroy
    assert_difference('Employment.count', -1) do
      delete :destroy, applicant_id: applicants(:one), id: employment
    end

    assert_redirected_to applicant_path(applicants(:one))
  end

  def test_update
    employment_update_hash = {
      employer_name: "x",
      end_date: "2000-01-01",
      phone: "x",
      position: "x",
      start_date: "2000-01-01",
      supervisor_name: "x",
    }
    put :update, applicant_id: applicants(:one), id: employment, employment: employment_update_hash
    assert_attributes_were_updated employments(:one), employment_update_hash.keys
    assert_redirected_to edit_applicant_employment_path(applicants(:one), employment)
  end

end
