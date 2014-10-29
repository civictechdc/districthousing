require "test_helper"

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_onboarding
    sign_in users(:one)
    get :onboarding
  end
end
