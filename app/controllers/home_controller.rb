class HomeController < ApplicationController

  def index
    @no_sidebar = true

    if current_user
      redirect_to picker_path
    end
  end

end
