class ApplicantController < ApplicationController

  def update
    @applicant = Applicant.find(params[:id])
    @applicant.update_attributes(params[:applicant])

    respond_to do |format|
      format.html { redirect_to picker_path }
      format.js
    end
  end

end
