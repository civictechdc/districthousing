class ApplicantController < ApplicationController

  def update
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      @applicant.update_attributes(params[:applicant])
      format.html { redirect_to picker_path }
    end
  end

end
