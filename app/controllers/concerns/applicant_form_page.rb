module ApplicantFormPage
  extend ActiveSupport::Concern

  included do
    before_action :set_applicant
  end

  def set_applicant
    if(params[:applicant_id])
      @applicant = Applicant.find(params[:applicant_id])
    else
      @applicant ||= @current_applicant
    end
  end

end
