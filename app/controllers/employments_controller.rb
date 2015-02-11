class EmploymentsController < ApplicationController
  include ApplicantFormPage

  private

  def this_section
    :employments
  end

  def first_item
    @applicant.employments.first
  end

  def last_item
    @applicant.employments.last
  end

  def make_new
    e = Employment.new
    e.address = Address.new
    e.person = @applicant.identity
    e
  end

  def set_model
    @model = Employment.find(params[:id])
  end

  def edit_model item
    edit_applicant_employment_path(@applicant, item)
  end

  def model_params
    params.require(:employment).permit(
      :person_id,
      :start_date,
      :end_date,
      :current,
      :employer_name,
      :supervisor_name,
      :position,
      :address_id,
      :phone,
      {address_attributes: [
        :street,
        :city,
        :state,
        :zip,
        :apt,
      ]})
  end

  def next_page
    find_next_page @applicant.employments, @model, :edit_model
  end

  def front_of_next_section
    edit_criminal_history_path(@applicant.criminal_histories.first)
  end

  def back_of_previous_section
    edit_income_path(@applicant.incomes.last)
  end
end
