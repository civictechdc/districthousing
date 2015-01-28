require "test_helper"

class ApplicantsControllerTest < ActionController::TestCase

  def test_new
    sign_in users(:one)
    get :new
    assert_response :success
  end

  def test_create
    sign_in users(:one)
    post :create, {
      first_name: "test_first_name",
      last_name: "test_last_name",
      household_member_count: 4,
      residence_count: 5,
      income_count: 6,
      employment_count: 7
    }

    created_applicant = Applicant.joins(:identity).
      where(
        people: {
          first_name: "test_first_name",
          last_name: "test_last_name" }).first

    assert_not_nil created_applicant
    assert_not_nil created_applicant.identity
    assert_not_nil created_applicant.identity.mail_address

    assert_redirected_to edit_identity_path(created_applicant)

    assert_equal users(:one).id, created_applicant.user_id
    assert_equal 4, created_applicant.household_members.count
    assert_equal 5, created_applicant.residences.count
    assert_equal 6, created_applicant.incomes.count
    assert_equal 7, created_applicant.employments.count
  end

  def test_show
    sign_in users(:one)
    get :show, id: applicants(:one)
    assert_response :success
  end

  def test_destroy
    sign_in users(:one)
    assert_difference('Applicant.count', -1) do
      delete :destroy, id: applicants(:one)
    end

    assert_redirected_to root_path
  end
end
