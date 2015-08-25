require "test_helper"

class HousingFormsControllerTest < ActionController::TestCase

  def setup
    # Use Mocha to stub filesystem operations in this test.
    HousingFormsController.any_instance.stubs(:make_tempname).returns("aTempName.pdf")
    HousingFormsController.any_instance.stubs(:call_file_write)
    HousingFormsController.any_instance.stubs(:delete_file)
    PDF_FORMS.stubs(:get_field_names).returns(['Field1', 'Field2'])

    # Prevent external geocoding API calls.
    HousingForm.any_instance.stubs(:geocode)
  end

  def housing_form
    @housing_form ||= housing_forms :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:housing_forms)
  end

  def test_new
    sign_in users(:one)
    get :new
    assert_response :success
  end

  def test_create_pdf_only
    sign_in users(:one)

    assert_difference('HousingForm.count') do
      post :create, housing_form: {
        new_form: fixture_file_upload('form.pdf', 'application/pdf')
      }
    end
    assert_not_nil assigns(:housing_form)
    assert_redirected_to housing_form_path(assigns(:housing_form))

    # If no name is given, derive the name from the uploaded filename
    assert_equal "form.pdf", assigns(:housing_form).name
    assert_equal "aTempName.pdf", assigns(:housing_form).path
  end

  def test_create_name_only
    sign_in users(:one)

    assert_difference('HousingForm.count') do
      post :create, housing_form: {
        name: "foo house"
      }
    end
    assert_not_nil assigns(:housing_form)
    assert_redirected_to housing_form_path(assigns(:housing_form))

    # If no PDF is given, the path should be nil.
    assert_equal nil,  assigns(:housing_form).path
  end

  def test_create_name_and_pdf
    sign_in users(:one)

    assert_difference('HousingForm.count') do
      post :create, housing_form: {
        new_form: fixture_file_upload('form.pdf', 'application/pdf'),
        name: 'My Form'
      }
    end
    assert_not_nil assigns(:housing_form)
    assert_redirected_to housing_form_path(assigns(:housing_form))

    assert_equal "My Form", assigns(:housing_form).name
    assert_equal "aTempName.pdf", assigns(:housing_form).path
  end

  def test_show
    sign_in users(:one)
    get :show, id: housing_form
    assert_response :success
    assert_equal applicants(:sample), assigns(:applicant)
    session[:current_applicant_id] = applicants(:one).id
    get :show, id: housing_form
    assert_response :success
    assert_equal applicants(:one), assigns(:applicant)
  end

  def test_show_no_login
    get :show, id: housing_form
    assert_response :success

    assert_equal applicants(:sample), assigns(:applicant)
  end

  def test_edit
    sign_in users(:one)
    get :edit, id: housing_form
    assert_response :success
  end

  def test_update
    sign_in users(:one)
    housing_form_update_hash = {
      name: "x",
      location: "x",
    }
    put :update, id: housing_form, housing_form: housing_form_update_hash
    assert_attributes_were_updated housing_forms(:one), housing_form_update_hash.keys
    assert_redirected_to housing_form_path(assigns(:housing_form))
  end

  def test_update_new_pdf_with_no_previous_pdf
    sign_in users(:one)
    housing_form_update_hash = {
      new_form: fixture_file_upload('form.pdf', 'application/pdf')
    }
    put :update, id: housing_forms(:no_pdf), housing_form: housing_form_update_hash
    assert_redirected_to housing_form_path(assigns(:housing_form))
    assert_equal "Form without a PDF", assigns(:housing_form).name
    assert_equal "aTempName.pdf", assigns(:housing_form).path
  end

  def test_update_new_pdf_replaces_previous_pdf
    sign_in users(:one)
    housing_form_update_hash = {
      new_form: fixture_file_upload('form.pdf', 'application/pdf')
    }
    put :update, id: housing_form, housing_form: housing_form_update_hash
    assert_redirected_to housing_form_path(assigns(:housing_form))
    assert_equal "Form with PDF", assigns(:housing_form).name
    assert_equal "some/path/to/a.pdf", assigns(:housing_form).path
  end

  def test_destroy
    HousingFormsController.any_instance.expects(:delete_file).with('some/path/to/a.pdf')
    sign_in users(:one)
    assert_difference('HousingForm.count', -1) do
      delete :destroy, id: housing_form
    end
    assert_redirected_to housing_forms_path
  end
end
