class LandlordController < ApplicationController

  def new
    current_applicant.household_members << Landlord.create do |ll|
      ll.residence = Residence.create
    end

    respond_to do |format|
      format.html { redirect_to picker_path }
    end
  end

end
