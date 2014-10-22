require "test_helper"

class HousingFormsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def housing_form
    @housing_form ||= housing_forms :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:housing_forms)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    sign_in users(:one)
    destination = Rails.root.join("public", "forms", "form.pdf")

    assert_difference('HousingForm.count') do
      post :create, housing_form: {
        new_form: fixture_file_upload('form.pdf', 'application/pdf')
      }
    end

    File.unlink destination if File.exists? destination

    assert_not_nil assigns(:housing_form)

    assert_redirected_to housing_form_path(assigns(:housing_form))
  end

  def test_show
    get :show, id: housing_form
    assert_response :success
  end

  def test_edit
    get :edit, id: housing_form
    assert_response :success
  end

  def test_update
    put :update, id: housing_form, housing_form: {  }
    assert_redirected_to housing_form_path(assigns(:housing_form))
  end

  def test_destroy
    sign_in users(:one)
    assert_difference('HousingForm.count', -1) do
      delete :destroy, id: housing_form
    end

    assert_redirected_to housing_forms_path
  end
end
