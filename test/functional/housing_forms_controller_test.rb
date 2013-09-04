require 'test_helper'

class HousingFormsControllerTest < ActionController::TestCase
  setup do
    @housing_form = housing_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:housing_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create housing_form" do
    assert_difference('HousingForm.count') do
      post :create, housing_form: { name: @housing_form.name, uri: @housing_form.uri }
    end

    assert_redirected_to housing_form_path(assigns(:housing_form))
  end

  test "should show housing_form" do
    get :show, id: @housing_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @housing_form
    assert_response :success
  end

  test "should update housing_form" do
    put :update, id: @housing_form, housing_form: { name: @housing_form.name, uri: @housing_form.uri }
    assert_redirected_to housing_form_path(assigns(:housing_form))
  end

  test "should destroy housing_form" do
    assert_difference('HousingForm.count', -1) do
      delete :destroy, id: @housing_form
    end

    assert_redirected_to housing_forms_path
  end
end
