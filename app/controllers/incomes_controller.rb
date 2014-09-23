class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def new
    @income = Income.new
  end

  # POST /incomes
  def create
    member = HouseholdMember.find(params[:memberId]);
    
    # if member doesn't exist or belongs to other applicant do not create income
    if (member != nil && current_applicant.household_members.include?(member))
      member.incomes << Income.create
    end
    
    redirect_to form_path
  end

  # PATCH/PUT /incomes/1
  def update
    if @income.update(income_params)
      redirect_to form_path, notice: 'Income was successfully updated.'
    else
      flash[:errors] = @income.errors.full_messages
      redirect_to form_path, notice: 'Unable to update income.'
    end
  end

  # DELETE /incomes/1
  def destroy
    @income.destroy
    redirect_to form_path, notice: 'Income was successfully destroyed.', status: :see_other
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
        :amount
        )
    end
end
