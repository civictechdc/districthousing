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
      redirect_to @criminal_history, notice: 'Criminal history was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /criminal_histories/1
  def update
    if @criminal_history.update(criminal_history_params)
      redirect_to @criminal_history, notice: 'Criminal history was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /criminal_histories/1
  def destroy
    @criminal_history.destroy
    redirect_to criminal_histories_url, notice: 'Criminal history was successfully destroyed.'
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
end
