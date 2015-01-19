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
    get :new
    assert_redirected_to edit_residence_path(assigns(:residence))
  end

  def test_create
    assert_difference('Residence.count') do
      post :create, residence: residence.attributes
    end

    assert_redirected_to edit_residence_path(assigns(:residence))
  end

  def test_update
    residence_update_hash = {
      start: "2000-01-01",
      end: "2010-01-01",
      reason: "x",
    }
    put :update, id: residence, residence: residence_update_hash
    assert_attributes_were_updated residences(:one), residence_update_hash.keys
    assert_redirected_to edit_residence_path(@residence)
  end

  def test_destroy
    assert_difference('Residence.count', -1) do
      delete :destroy, id: residence
    end

    assert_redirected_to applicant_path(applicants(:one))
  end
end
