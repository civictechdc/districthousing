class HouseholdMembersController < ApplicationController
  before_action :set_household_member, only: [:show, :edit, :update, :destroy]

  def edit
    @household_member = HouseholdMember.find(params[:id])
    @person = @household_member.person
  end

  def new
    create
  end

  def create
    @h = HouseholdMember.new
    @h.person = selected_or_created_person
    @h.applicant = current_applicant

    if @h.save
      redirect_to edit_household_member_path(@h)
    else
      flash.alert = "Error: #{@h.errors.messages}"
      render :new
    end
  end

  def show
    @household_member = HouseholdMember.find(params[:id])
  end

  def update
    if @household_member.update(household_member_params)
      redirect_to next_page
    else
      redirect_to edit_household_member_path(@household_member), notice: 'Couldn\'t save.'
    end
  end

  def destroy
    @household_member.destroy
    redirect_to current_applicant, notice: 'Household member removed', status: :see_other
  end

  private

  def set_household_member
    @household_member = HouseholdMember.find(params[:id])
  end

  def household_member_params
    params.require(:household_member).permit(
      person_attributes: [
        :id,
        :relationship,
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
        :nationality,
        :email,
        :race,
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
      person.applicant = current_applicant
      person.mail_address = Address.new
      return person
    else
      return Person.find(params[:person_id])
    end
  end

  def next_page
    find_next_page @current_applicant.household_members, @household_member, :edit_household_member_path
  end

  def front_of_next_section
    edit_residence_path(@current_applicant.residences.first)
  end

  def back_of_previous_section
    edit_person_path(@current_applicant.identity)
  end
end
