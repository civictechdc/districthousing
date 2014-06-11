class HouseholdMemberController < ApplicationController

  def new
    current_applicant.household_members << HouseholdMember.create do |hh|
      hh.residence = Residence.create
    end

    respond_to do |format|
      format.html { redirect_to picker_path }
    end
  end

end
