require "test_helper"

class IncomesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:one)
  end

  def income
    incomes :one
  end

  def test_new
    assert_difference('Income.count') do
      get :new, applicant_id: applicants(:one)
    end

    assert_redirected_to edit_applicant_income_path(applicants(:one), assigns[:model])
  end

  def test_edit
    get :edit, applicant_id: applicants(:one), id: incomes(:one)
    assert_response :success
  end

  def test_edit_empty
    get :front, applicant_id: applicants(:empty)
    assert_response :success
  end

  def test_destroy
    assert_difference('Income.count', -1) do
      delete :destroy, applicant_id: applicants(:one), id: income
    end

    assert_redirected_to applicant_path(applicants(:one))
  end

  def test_update
    assert income.amount = 123
    assert income.person_id = 1
    assert income.income_type = "salary"
    assert income.interval = "yearly"

    put :update, applicant_id: applicants(:one), id: income, income: {
      amount: 456,
      person_id: 2,
      income_type: "tips",
      interval: "weekly"
    }

    assert income.amount = 456
    assert income.person_id = 2
    assert income.income_type = "tips"
    assert income.interval = "weekly"

    assert_redirected_to edit_applicant_income_path(applicants(:one), income)
  end

end
