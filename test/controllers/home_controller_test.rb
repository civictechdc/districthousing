require "test_helper"

class HomeControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_index
    get :index
  end

  def test_index_signed_in
    sign_in users(:one)
    get :index
  end
end
