require "test_helper"

class DictionaryControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_index
    sign_in users(:one)
    get :index
    assert_equal 1, assigns(:applicant).id
  end

  def test_index_no_login
    get :index
    assert_equal 3, assigns(:applicant).id
  end

end
