class HomeController < ApplicationController

  def index
    @no_sidebar = true
    @landing = true

    if current_user
      redirect_to picker_path
    end
  end

end
