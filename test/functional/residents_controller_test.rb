require 'test_helper'

class ResidentsControllerTest < ActionController::TestCase
  setup do
    @resident = residents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:residents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resident" do
    assert_difference('Resident.count') do
      post :create, resident: { dob: @resident.dob, first_name: @resident.first_name, gender: @resident.gender, last_name: @resident.last_name, middle_name: @resident.middle_name, res_apt: @resident.res_apt, res_city: @resident.res_city, res_state: @resident.res_state, res_street_address: @resident.res_street_address, res_zip: @resident.res_zip, ssn: @resident.ssn }
    end

    assert_redirected_to resident_path(assigns(:resident))
  end

  test "should show resident" do
    get :show, id: @resident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resident
    assert_response :success
  end

  test "should update resident" do
    put :update, id: @resident, resident: { dob: @resident.dob, first_name: @resident.first_name, gender: @resident.gender, last_name: @resident.last_name, middle_name: @resident.middle_name, res_apt: @resident.res_apt, res_city: @resident.res_city, res_state: @resident.res_state, res_street_address: @resident.res_street_address, res_zip: @resident.res_zip, ssn: @resident.ssn }
    assert_redirected_to resident_path(assigns(:resident))
  end

  test "should destroy resident" do
    assert_difference('Resident.count', -1) do
      delete :destroy, id: @resident
    end

    assert_redirected_to residents_path
  end
end
