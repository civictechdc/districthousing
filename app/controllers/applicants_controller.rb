class ApplicantsController < ApplicationController

  def update
    @applicant = current_applicant
    @applicant.update_attributes(params[:applicant])

    respond_to do |format|
      format.html { redirect_to apply_path }
    end
  end

end
