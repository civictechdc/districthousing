require "test_helper"

class ApplicantsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_new
    sign_in users(:one)
    get :new
    assert_response :success
  end

  def test_create
    sign_in users(:one)
    post :create, {
      first_name: "test_first_name",
      last_name: "test_last_name"
    }

    created_applicant = Applicant.joins(:identity).
      where(
        people: {
          first_name: "test_first_name",
          last_name: "test_last_name" })

    assert_redirected_to created_applicant.first

    assert_equal users(:one).id, created_applicant.first.user_id
  end

  def test_show
    sign_in users(:one)
    get :show, id: users(:one).id
    assert_response :success
  end
end
