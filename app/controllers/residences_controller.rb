class ResidencesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_residence, only: [:show, :edit, :update, :destroy]

  def new
    current_applicant.residences << Residence.make_a_residence

    redirect_to apply_path
  end

  # POST /residences
  def create
    @residence = Residence.new(residence_params)

    if @residence.save
      redirect_to @residence
    else
      redirect_to :new
    end
  end

  # PATCH/PUT /residences/1
  def update
    if @residence.update(residence_params)
      redirect_to apply_path, notice: 'Residence was successfully updated.'
    else
      redirect_to apply_path, notice: 'Residence could not be updated.'
    end
  end

  # DELETE /residences/1
  def destroy
    @residence.destroy
    redirect_to apply_path, notice: 'Residence was successfully destroyed.', status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_residence
      @residence = Residence.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def residence_params
      params.require(:residence).permit(
        :applicant_id,
        :address_id,
        :start,
        :end,
        :reason,
        :landlord_id,
        address_attributes: [ :street, :apt, :city, :state, :zip, :id ],
        landlord_attributes: [ :first_name, :middle_name, :last_name,
          :cell_phone, :home_phone, :work_phone, :email, :id ] )
    end
end
