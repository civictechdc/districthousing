require "test_helper"

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_onboarding
    get :onboarding
  end
end
