class ApplicantController < ApplicationController

  def update
    @applicant = Applicant.find(params[:id])

    respond_to do |format|
      if @applicant.update_attributes(params[:applicant])
        logger.info "It worked!"
      else
        logger.info "It failed!"
      end
      format.html { redirect_to picker_path }
    end
  end

end
