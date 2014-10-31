class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if user_signed_in?
      @applicants = current_user.applicants
      render :control
    end
  end

  def onboarding
  end

end
