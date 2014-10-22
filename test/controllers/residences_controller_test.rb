require "test_helper"

class ResidencesControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  def residence
    @residence ||= residences :one
  end

  def test_index
    sign_in users(:one)
    get :index
    assert_response :success
    assert_not_nil assigns(:residences)
  end

  def test_new
    sign_in users(:one)
    get :new
    assert_response :success
  end

  def test_create
    sign_in users(:one)
    assert_difference('Residence.count') do
      post :create, residence: {
        end: residence.end,
        reason: residence.reason,
        start: residence.start
      }
    end

    assert_redirected_to residence_path(assigns(:residence))
  end

  def test_show
    sign_in users(:one)
    get :show, id: residence
    assert_response :success
  end

  def test_edit
    sign_in users(:one)
    get :edit, id: residence
    assert_response :success
  end

  def test_update
    put :update, id: residence, residence: { address_id: @residence.address_id, applicant_id: @residence.applicant_id, end: @residence.end, landlord_id: @residence.landlord_id, reason: @residence.reason, start: @residence.start }
    assert_redirected_to residence_path(assigns(:residence))
  end

  def test_destroy
    sign_in users(:one)
    assert_difference('Residence.count', -1) do
      delete :destroy, id: residence
    end

    assert_redirected_to residences_path
  end
end
