require "test_helper"

class IncomesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def income
    incomes :one
  end

  def setup
    sign_in users(:one)
    session[:current_applicant_id] = applicants(:one).id
  end

  def test_new
    get :new
    assert_redirected_to edit_income_path(assigns[:income])
  end

  def test_create
    assert_difference('Income.count') do
      post :create, income: {
        amount: 123,
        income_type_id: 1,
        person_id: 1
      }
    end

    assert_redirected_to edit_income_path(assigns[:income])
  end

  def test_update
    assert income.amount = 123
    assert income.person_id = 1
    assert income.income_type_id = 1

    put :update, id: income, income: {
      amount: 456,
      person_id: 2,
      income_type_id: 2,
    }

    assert income.amount = 456
    assert income.person_id = 2
    assert income.income_type_id = 2

    assert_redirected_to edit_income_path(income)
  end

  def test_destroy
    assert_difference('Income.count', -1) do
      delete :destroy, id: income
    end

    assert_redirected_to applicant_path(applicants(:one))
  end

end
