class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def new
    create
  end

  def create
    income = Income.new
    income.person = @current_applicant.identity

    if income.save
      redirect_to edit_income_path(income)
    else
      redirect_to :new
    end
  end

  def update
    if @income.update(income_params)
      redirect_to next_page
    else
      flash[:errors] = @income.errors.full_messages
      redirect_to current_applicant, notice: 'Unable to update income.'
    end
  end

  def edit
  end

  def destroy
    @income.destroy
    redirect_to current_applicant, notice: 'Income was successfully destroyed.', status: :see_other
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_income
    @income = Income.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def income_params
    params.require(:income).permit(
      :income_type_id,
      :amount,
      :person_id,
    )
  end

  def next_page
    find_next_page @current_applicant.incomes, @income, :edit_income_path
  end

  def front_of_next_section
    edit_employment_path(@current_applicant.employments.first)
  end

  def back_of_previous_section
    edit_residence_path(@current_applicant.residences.last)
  end
end
