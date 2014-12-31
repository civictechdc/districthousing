require "test_helper"

class SalesforceApplicantsControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  def setup
    sign_in users(:one)
  end

  def salesforce_applicant
    @salesforce_applicant ||= salesforce_applicants :one
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:salesforce_applicants)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('SalesforceApplicant.count') do
      post :create, salesforce_applicant: { name: salesforce_applicant.name, applicant_id: 1 }
    end

    assert_redirected_to salesforce_applicant_path(assigns(:salesforce_applicant))
  end

  def test_show
    get :show, id: salesforce_applicant
    assert_response :success
  end

  def test_edit
    get :edit, id: salesforce_applicant
    assert_response :success
  end

  def test_update
    put :update, id: salesforce_applicant, salesforce_applicant: { name: @salesforce_applicant.name }
    assert_redirected_to salesforce_applicant_path(assigns(:salesforce_applicant))
  end

  def test_destroy
    assert_difference('SalesforceApplicant.count', -1) do
      delete :destroy, id: salesforce_applicant
    end

    assert_redirected_to salesforce_applicants_path
  end

  def test_sync
    SalesforceApplicantsController.any_instance.stubs(:intakes).returns(
      [
        FakeIntake.new(
          Name: "123456",
          FirstName__c: "Joe",
          LastName__c: "Test"
        )
      ]
    )
    assert_difference('Applicant.count', 1) do
      assert_difference('SalesforceApplicant.count', 1) do
        get :sync
      end
    end

    assert_redirected_to home_index_path
  end

end
