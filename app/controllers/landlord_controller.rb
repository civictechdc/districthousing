class LandlordController < ApplicationController

  def new
    current_applicant.landlords << Landlord.create

    respond_to do |format|
      format.html { redirect_to picker_path }
    end
  end

end
