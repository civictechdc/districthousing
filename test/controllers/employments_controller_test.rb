require "test_helper"

class EmploymentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in users(:one)
    session[:current_applicant_id] = 1
  end

  def employment
    @employment ||= employments :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:employments)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('Employment.count') do
      post :create, employment: { address_id: employment.address_id, employer_name: employment.employer_name, end_date: employment.end_date, person_id: employment.person_id, phone: employment.phone, position: employment.position, start_date: employment.start_date, supervisor_name: employment.supervisor_name }
    end

    assert_redirected_to applicant_path(applicants(:one))
  end

  def test_show
    get :show, id: employment
    assert_response :success
  end

  def test_edit
    get :edit, id: employment
    assert_response :success
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
    put :update, id: employment, employment: employment_update_hash
    assert_attributes_were_updated employments(:one), employment_update_hash.keys
    assert_redirected_to applicant_path(applicants(:one))
  end

  def test_destroy
    assert_difference('Employment.count', -1) do
      delete :destroy, id: employment
    end

    assert_redirected_to applicant_path(applicants(:one))
  end
end
