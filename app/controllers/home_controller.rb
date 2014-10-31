class HomeController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    if current_user
      redirect_to onboarding_path
    end
  end

  def onboarding
  end

end
