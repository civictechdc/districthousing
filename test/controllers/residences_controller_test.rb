require "test_helper"

class ResidencesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
    session[:current_applicant_id] = applicants(:one).id
  end

  def residence
    @residence ||= residences :one
  end

  def test_new
    assert_difference('Residence.count') do
      get :new, applicant_id: applicants(:one)
    end

    assert_redirected_to edit_applicant_residence_path(applicants(:one), assigns(:residence))
  end

  def test_update
    residence_update_hash = {
      start: "2000-01-01",
      end: "2010-01-01",
      reason: "x",
    }
    put :update, applicant_id: applicants(:one), id: residence, residence: residence_update_hash
    assert_attributes_were_updated residences(:one), residence_update_hash.keys
    assert_redirected_to edit_applicant_residence_path(applicants(:one), @residence)
  end

  def test_edit
    get :edit, applicant_id: applicants(:one), id: residences(:one)
    assert_response :success
  end

  def test_edit_empty
    get :front, applicant_id: applicants(:empty)
    assert_response :success
  end

  def test_destroy
    assert_difference('Residence.count', -1) do
      delete :destroy, applicant_id: applicants(:one), id: residence
    end

    assert_redirected_to applicant_path(applicants(:one))
  end
end
