class HouseholdMembersController < ApplicationController
  before_action :set_household_member, only: [:show, :edit, :update, :destroy]

  def edit
    @household_member = HouseholdMember.find(params[:id])
    @person = @household_member.person
  end

  def front
    @applicant = Applicant.find(params[:applicant_id])
    @household_member = @applicant.household_members.first
    if @household_member.nil?
      render :empty
    else
      redirect_to edit_applicant_household_member_path(@applicant, @household_member)
    end
  end

  def new
    @h = HouseholdMember.create
    @h.person = selected_or_created_person
    @h.applicant = Applicant.find(params[:applicant_id])

    if @h.save
      redirect_to edit_applicant_household_member_path(@h.applicant, @h)
    else
      flash.alert = "Error: #{@h.errors.messages}"
      redirect_to @applicant
    end
  end

  def update
    if @household_member.update(household_member_params)
      redirect_to next_page
    else
      redirect_to edit_applicant_household_member_path(@applicant, @household_member), notice: 'Couldn\'t save.'
    end
  end

  def destroy
    @household_member.destroy
    redirect_to @applicant, notice: 'Household member removed', status: :see_other
  end

  private

  def set_household_member
    @applicant = Applicant.find(params[:applicant_id])
    @household_member = HouseholdMember.find(params[:id])
  end

  def household_member_params
    params.require(:household_member).permit(
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
    find_next_page @applicant.household_members, @household_member, :edit_me
  end

  def edit_me item
    edit_applicant_household_member_path(@applicant, item)
  end

  def front_of_next_section
    edit_residences_path(@applicant)
  end

  def back_of_previous_section
    edit_applicant_identity_path(@applicant)
  end
end
