class IdentityController < ApplicationController
  before_action :assign_applicant

  def edit
  end

  def update
    if @applicant.identity.update(person_params)
      redirect_to next_page
    else
      render :edit
    end
  end

  private

  def person_params
    params.require(:person).permit(
      :dob,
      :first_name,
      :gender,
      :last_name,
      :middle_name,
      :res_apt,
      :ssn,
      :work_phone,
      :home_phone,
      :cell_phone,
      :preferred_phone,
      :citizenship,
      :country_of_birth,
      :email,
      :race,
      :ethnicity,
      :student_status,
      :marital_status,
      :occupation,
      :state_of_birth,
      :city_of_birth,
      :driver_license_number,
      :driver_license_state,
      mail_address_attributes: [
        :street,
        :city,
        :state,
        :zip,
        :apt,
      ]
    )
  end

  def next_page
    if params[:submit_direction] == "next"
      edit_household_members_path(@applicant)
    elsif params[:submit_direction] == "previous"
      @applicant
    else
      flash[:notice] = "Saved!"
      edit_identity_path(@applicant)
    end
  end

  def assign_applicant
    @applicant = Applicant.find(params[:id])
  end
end
