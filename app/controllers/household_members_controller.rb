class HouseholdMembersController < ApplicationController
  before_action :set_household_member, only: [:show, :edit, :update, :destroy]

  def new
    @possible_people = current_applicant.people
  end

  def create
    @h = HouseholdMember.new
    @h.person = selected_or_created_person
    @h.applicant = current_applicant

    if @h.save
      redirect_to edit_person_path(@h.person)
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
      redirect_to apply_path, notice: 'Housing form was successfully updated.'
    else
      redirect_to apply_path, notice: 'Housing form could not be updated.'
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
    params[:household_member]
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
end
