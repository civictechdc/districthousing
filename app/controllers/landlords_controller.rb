class LandlordsController < ApplicationController

  def new
    current_applicant.landlords << Landlord.create do |ll|
      ll.residence = Residence.create
    end

    @applicant = current_applicant

    respond_to do |format|
      format.html { redirect_to apply_path }
    end
  end

end
