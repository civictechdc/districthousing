require "test_helper"

class ApplicantsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_create
    sign_in users(:one)
    post :create
    assert_redirected_to applicant_path(assigns(:applicant))
  end
end
