require "test_helper"

class DictionaryControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_index
    get :index
    assert_not_nil assigns(:applicant)
  end
end
