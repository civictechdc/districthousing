class DictionaryController < ApplicationController
  before_action :authenticate_user!

  def index
    @applicant = current_applicant
  end
end
