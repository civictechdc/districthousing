class HomeController < ApplicationController

  def index
    @no_sidebar = true
    @landing = true

    if current_user
      redirect_to onboarding_path
    end
  end

  def onboarding
  end

end
