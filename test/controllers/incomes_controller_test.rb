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
    assert_equal 123, income.amount
    assert_equal people(:one), income.person
    assert_equal "salary", income.income_type
    assert_equal "yearly", income.interval

    put :update, applicant_id: applicants(:one), id: income, income: {
      amount: 456,
      person_id: people(:two),
      income_type: "tips",
      interval: "weekly"
    }

    updated_income = Income.find(income.id)

    assert_equal 456, updated_income.amount
    assert_equal people(:two).id, updated_income.person_id
    assert_equal "tips", updated_income.income_type
    assert_equal "weekly", updated_income.interval

    assert_redirected_to edit_applicant_income_path(applicants(:one), income)
  end

end
