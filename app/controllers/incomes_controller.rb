class IncomesController < ApplicationController
  include ApplicantFormPage

  private

  def this_section
    :incomes
  end

  def first_item
    @applicant.incomes.first
  end

  def last_item
    @applicant.incomes.last
  end

  def make_new
    i = Income.new
    i.person = @applicant.identity
    i
  end

  def set_model
    @model = Income.find(params[:id])
  end

  def edit_model item
    edit_applicant_income_path(@applicant, item)
  end

  def model_params
    params.require(:income).permit(
      :income_type,
      :amount,
      :person_id,
      :interval,
    )
  end

  def next_page
    find_next_page @applicant.incomes, @model, :edit_model
  end

  def front_of_next_section
    edit_employment_path(@applicant.employments.first)
  end

  def back_of_previous_section
    edit_applicant_criminal_history_path(@applicant.criminal_histories.last)
  end
end
