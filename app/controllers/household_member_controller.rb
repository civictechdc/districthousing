class HouseholdMemberController < ApplicationController

  def new
    current_applicant.household_members << HouseholdMember.create do |hh|
      hh.residence = Residence.create
    end

    @applicant = current_applicant

    respond_to do |format|
      format.html { redirect_to form_path }
      format.js { render action: "refresh_form" }
    end
  end

end
