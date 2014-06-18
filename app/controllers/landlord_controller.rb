class LandlordController < ApplicationController

  def new
    current_applicant.landlords << Landlord.create do |ll|
      ll.residence = Residence.create
    end

    @applicant = current_applicant

    respond_to do |format|
      format.html { redirect_to form_path }
      format.js { render action: "refresh_form" }
    end
  end

end
