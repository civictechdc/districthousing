require "test_helper"

class CriminalHistoriesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    sign_in users(:one)
    session[:current_applicant_id] = 1
  end

  def criminal_history
    @criminal_history ||= criminal_histories :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:criminal_histories)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('CriminalHistory.count') do
      post :create, criminal_history: { crime_type_id: criminal_history.crime_type_id, description: criminal_history.description, person_id: criminal_history.person_id, year: criminal_history.year }
    end

    assert_redirected_to applicants(:one)
  end

  def test_show
    get :show, id: criminal_history
    assert_response :success
  end

  def test_edit
    get :edit, id: criminal_history
    assert_response :success
  end

  def test_update
    put :update, id: criminal_history, criminal_history: { crime_type_id: @criminal_history.crime_type_id, description: @criminal_history.description, person_id: @criminal_history.person_id, year: @criminal_history.year }
    assert_redirected_to edit_criminal_history_path(@criminal_history)
  end

  def test_destroy
    assert_difference('CriminalHistory.count', -1) do
      delete :destroy, id: criminal_history
    end

    assert_redirected_to applicants(:one)
  end
end
