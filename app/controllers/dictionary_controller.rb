class DictionaryController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if params[:applicant_id]
      @applicant = Applicant.find(params[:applicant_id])
    else
      @applicant = sample_applicant
    end
  end
end
