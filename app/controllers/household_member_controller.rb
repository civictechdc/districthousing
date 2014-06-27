class HouseholdMemberController < ApplicationController
  before_action :set_household_member, only: [:show, :edit, :update, :destroy]

  def new
    current_applicant.household_members << HouseholdMember.create do |hh|
      hh.residence = Residence.create
    end

    @applicant = current_applicant

    respond_to do |format|
      format.html { redirect_to form_path }
    end
  end

  def update
    if @household_member.update(household_member_params)
      redirect_to form_path, notice: 'Housing form was successfully updated.'
    else
      redirect_to form_path, notice: 'Housing form could not be updated.'
    end
  end

  private

  def set_household_member
    @household_member = HouseholdMember.find(params[:id])
  end

  def household_member_params
    params[:household_member]
  end
end
