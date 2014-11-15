class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def new
    @income = Income.new
  end

  def create
    income = Income.create(income_params)

    if income.save
      redirect_to current_applicant
    else
      redirect_to :new
    end
  end

  def update
    if @income.update(income_params)
      redirect_to current_applicant, notice: 'Income was successfully updated.'
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
end
