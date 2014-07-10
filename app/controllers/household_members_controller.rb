class HouseholdMembersController < ApplicationController
  before_action :set_household_member, only: [:show, :edit, :update, :destroy]

  def new
    current_applicant.household_members << HouseholdMember.create
    redirect_to form_path
  end

  def update
    if @household_member.update(household_member_params)
      redirect_to form_path, notice: 'Housing form was successfully updated.'
    else
      redirect_to form_path, notice: 'Housing form could not be updated.'
    end
  end

  def destroy
    @household_member.destroy
    redirect_to form_path, notice: 'Household member removed', status: :see_other
  end

  private

  def set_household_member
    @household_member = HouseholdMember.find(params[:id])
  end

  def household_member_params
    params[:household_member]
  end
end
