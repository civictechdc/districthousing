class ResidencesController < ApplicationController

  before_action :set_residence, only: [:edit, :update, :destroy]
  before_action :set_person_mail_address, only: [:edit, :update]

  def new
    create
  end

  # POST /residences
  def create
    @residence = Residence.new

    @residence.applicant = current_applicant
    @residence.landlord = Person.new
    @residence.landlord.applicant = current_applicant

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
      redirect_to next_page
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

    def set_person_mail_address
      @mail_address = @residence.applicant.identity.mail_address
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
      find_next_page @current_applicant.residences, @residence, :edit_residence_path
    end

    def front_of_next_section
      edit_income_path(@current_applicant.incomes.first)
    end

    def back_of_previous_section
      edit_household_member_path(@current_applicant.household_members.last)
    end
end
