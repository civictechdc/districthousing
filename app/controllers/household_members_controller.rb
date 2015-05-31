class HouseholdMembersController < ApplicationController
  include ApplicantFormPage

  private

  def this_section
    :household_members
  end

  def first_item
    @applicant.household_members.first
  end

  def last_item
    @applicant.household_members.last
  end

  def make_new
    h = HouseholdMember.create
    h.person = selected_or_created_person
    h.applicant = @applicant
    h
  end

  def set_model
    @model = HouseholdMember.find(params[:id])
  end

  def model_params
    params.require(:household_member).permit(
      :relationship,
      person_attributes: [
        :id,
        :dob,
        :first_name,
        :gender,
        :last_name,
        :middle_name,
        :res_apt,
        :ssn,
        :phone,
        :work_phone,
        :home_phone,
        :cell_phone,
        :preferred_phone,
        :citizenship,
        :country_of_birth,
        :email,
        :race,
        :ethnicity,
        :student_status,
        :marital_status,
        :occupation,
        :state_of_birth,
        :city_of_birth,
        :driver_license_number,
        :driver_license_state,
        :driver_license_exp_date,
        mail_address_attributes: [
          :id,
          :street,
          :city,
          :state,
          :zip,
          :apt,
        ]
      ]
    )
  end

  def selected_or_created_person
    if params[:person_id].blank?
      person = Person.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
      )
      person.applicant = @applicant
      return person
    else
      return Person.find(params[:person_id])
    end
  end

  def next_page
    find_next_page @applicant.household_members, @model, :edit_model
  end

  def edit_model item
    edit_applicant_household_member_path(@applicant, item)
  end

  def front_of_next_section
    edit_residences_path(@applicant)
  end

  def back_of_previous_section
    edit_applicant_identity_path(@applicant)
  end
end
