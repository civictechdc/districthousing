class PdfGuideController < ApplicationController
  before_action :authenticate_user!
  def index
    @applicant = current_applicant
  end
end
