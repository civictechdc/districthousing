class ResidencesController < ApplicationController
  include ApplicantFormPage

  def this_section
    :residences
  end

  def first_item
    @applicant.residences.first
  end

  def last_item
    @applicant.residences.last
  end

  def make_new
    residence = Residence.new
    residence.applicant = @applicant
    residence.landlord = Person.new
    residence.landlord.applicant = @applicant
    residence
  end

  def set_model
    @model = Residence.find(params[:id])
  end

  def model_params
    params.require(:residence).permit(
      :applicant_id,
      :address_id,
      :start,
      :end,
      :current,
      :reason,
      :rent,
      :landlord_id,
      {address_attributes: [:street, :apt, :city, :state, :zip, :id]},
      {landlord_attributes: [:first_name, :middle_name, :last_name, :cell_phone, :home_phone, :work_phone, :email, :id,
                             mail_address_attributes: [:street, :apt, :city, :state, :zip, :id]]})
  end

  def next_page
    find_next_page @applicant.residences, @model, :edit_model
  end

  def edit_model item
    edit_applicant_residence_path(@applicant, item)
  end

  def front_of_next_section
    edit_income_path(@applicant.incomes.first)
  end

  def back_of_previous_section
    edit_household_member_path(@applicant.household_members.last)
  end
end
