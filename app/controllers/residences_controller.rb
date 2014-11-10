class ResidencesController < ApplicationController

  before_action :set_residence, only: [:edit, :update, :destroy]

  def new
    @residence = Residence.new
  end

  # POST /residences
  def create
    @residence = Residence.new(
      start: params[:start],
      end: params[:end],
      reason: params[:reason]
    )

    @residence.applicant = current_applicant
    @residence.address = Address.new

    if @residence.save
      redirect_to edit_residence_path(@residence)
    else
      flash.alert = "Error: #{@residence.errors.messages}"
      render :new
    end
  end

  def edit
  end

  # PATCH/PUT /residences/1
  def update
    if @residence.update(residence_params)
      redirect_to current_applicant
    else
      flash.alert = "Error: #{@residence.errors.messages}"
      redirect_to update_residence_path(@residence)
    end
  end

  # DELETE /residences/1
  def destroy
    @residence.destroy
    redirect_to current_applicant
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_residence
      @residence = Residence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def residence_params
      params.permit(residence: [:applicant_id, :address_id, :start, :end, :reason, :landlord_id, {address_attributes: [:street, :apt, :city, :state, :zip, :id]}, {landlord_attributes: [:first_name, :middle_name, :last_name, :cell_phone, :home_phone, :work_phone, :email, :id]}])[:residence]
    end
end
