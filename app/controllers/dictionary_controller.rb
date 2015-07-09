class DictionaryController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_applicant

  def index
  end

  def test
    result = @applicant.value_for_field(params[:field_name])

    respond_to do |format|
      format.json {
        render :json => {
          'result' => result.to_s,
          'recognized' => result.class != UnknownField
        }.to_json
      }
    end
  end

  private

  def set_applicant
    @applicant = current_applicant || sample_applicant
  end
end
