class CriminalHistoriesController < ApplicationController
  before_action :set_criminal_history, only: [:show, :edit, :update, :destroy]

  # GET /criminal_histories
  def index
    @criminal_histories = CriminalHistory.all
  end

  # GET /criminal_histories/1
  def show
  end

  # GET /criminal_histories/new
  def new
    @criminal_history = CriminalHistory.new
  end

  # GET /criminal_histories/1/edit
  def edit
  end

  # POST /criminal_histories
  def create
    @criminal_history = CriminalHistory.new(criminal_history_params)

    if @criminal_history.save
      redirect_to current_applicant
    else
      render :new
    end
  end

  # PATCH/PUT /criminal_histories/1
  def update
    if @criminal_history.update(criminal_history_params)
      redirect_to next_page
    else
      render :edit
    end
  end

  # DELETE /criminal_histories/1
  def destroy
    @criminal_history.destroy
    redirect_to current_applicant
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criminal_history
      @criminal_history = CriminalHistory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def criminal_history_params
      params.require(:criminal_history).permit(:person_id, :crime_type_id, :description, :year)
    end

    def next_page
      find_next_page @current_applicant.criminal_histories, @criminal_history, :edit_criminal_history_path
    end

    def front_of_next_section
      # Criminal history is the last section, so send the user back to the summary page
      @current_applicant
    end

    def back_of_previous_section
      edit_employment_path(@current_applicant.employments.last)
    end
end
