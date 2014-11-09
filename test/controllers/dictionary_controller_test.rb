require "test_helper"

class DictionaryControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def test_index
    sign_in users(:one)
    get :index
    assert_equal applicants(:sample), assigns(:applicant)
    session[:current_applicant_id] = applicants(:one).id
    get :index
    assert_equal applicants(:one), assigns(:applicant)
  end

  def test_index_no_login
    get :index
    assert_equal 3, assigns(:applicant).id
  end

end
