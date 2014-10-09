class DictionaryController < ApplicationController
  def index
    @applicant = sample_applicant
  end
end
