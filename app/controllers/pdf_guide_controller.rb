class PdfGuideController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @applicant = sample_applicant
  end
end
