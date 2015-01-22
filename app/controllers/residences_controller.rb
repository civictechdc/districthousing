class ResidencesController < ApplicationController

  before_action :set_residence, only: [:edit, :update, :destroy]

  def front
    @applicant = Applicant.find(params[:applicant_id])
    @residence = @applicant.residences.first
    if @residence.nil?
      render :empty
    else
      redirect_to edit_applicant_residence_path(@applicant, @residence)
    end
  end

  def new
    @residence = Residence.new

    @applicant = Applicant.find(params[:applicant_id])
    @residence.applicant = @applicant
    @residence.landlord = Person.new
    @residence.landlord.applicant = @applicant

    if @residence.save
      redirect_to edit_applicant_residence_path(@applicant, @residence)
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
      redirect_to next_page
    else
      flash.alert = "Error: #{@residence.errors.messages}"
      redirect_to update_applicant_residence_path(@applicant, @residence)
    end
  end

  # DELETE /residences/1
  def destroy
    @residence.destroy
    redirect_to @applicant, notice: 'Residence removed', status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_residence
      @applicant = Applicant.find(params[:applicant_id])
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
        {address_attributes: [:street, :apt, :city, :state, :zip, :id]},
        {landlord_attributes: [:first_name, :middle_name, :last_name, :cell_phone, :home_phone, :work_phone, :email, :id,
                               mail_address_attributes: [:street, :apt, :city, :state, :zip, :id]]})
    end

    def next_page
      find_next_page @current_applicant.residences, @residence, :edit_me
    end

    def edit_me item
      edit_applicant_residence_path(@applicant, item)
    end

    def front_of_next_section
      edit_income_path(@current_applicant.incomes.first)
    end

    def back_of_previous_section
      edit_household_member_path(@current_applicant.household_members.last)
    end
end
