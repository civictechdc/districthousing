require "test_helper"

class EmploymentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in users(:one)
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

    assert_redirected_to employment_path(assigns(:employment))
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
    put :update, id: employment, employment: { address_id: employment.address_id, employer_name: employment.employer_name, end_date: employment.end_date, person_id: employment.person_id, phone: employment.phone, position: employment.position, start_date: employment.start_date, supervisor_name: employment.supervisor_name }
    assert_redirected_to employment_path(assigns(:employment))
  end

  def test_destroy
    assert_difference('Employment.count', -1) do
      delete :destroy, id: employment
    end

    assert_redirected_to employments_path
  end
end
