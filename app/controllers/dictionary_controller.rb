class DictionaryController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @applicant = current_applicant
  end
end
