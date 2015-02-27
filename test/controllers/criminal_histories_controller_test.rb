require "test_helper"

class CriminalHistoriesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  def criminal_history
    @criminal_history ||= criminal_histories :one
  end

  def test_new
    assert_difference('CriminalHistory.count') do
      get :new, applicant_id: applicants(:one)
    end

    assert_redirected_to edit_applicant_criminal_history_path(applicants(:one), assigns(:model))
  end

  def test_edit
    get :edit, id: criminal_history
    assert_response :success
  end

  def test_edit
    get :front, applicant_id: applicants(:empty)
    assert_response :success
  end

  def test_destroy
    assert_difference('CriminalHistory.count', -1) do
      delete :destroy, applicant_id: applicants(:one), id: criminal_history
    end

    assert_redirected_to applicants(:one)
  end

  def test_update
    put :update, applicant_id: applicants(:one), id: criminal_history, criminal_history: { crime_type: @criminal_history.crime_type, description: @criminal_history.description, person_id: @criminal_history.person_id, year: @criminal_history.year }
    assert_redirected_to edit_applicant_criminal_history_path(applicants(:one), @criminal_history)
  end

end
