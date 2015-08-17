class IdentityController < ApplicationController
  include ApplicantFormPage

  private

  def this_section
    :identity
  end

  def first_item
    @applicant.identity
  end

  def last_item
    @applicant.identity
  end

  def set_model
    @model = @applicant.identity
  end

  def edit_model model
    edit_identity_path(@applicant)
  end

  def model_params
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
      :driver_license_exp_date,
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
      @next_section_path
    elsif params[:submit_direction] == "previous"
      @applicant
    else
      edit_identity_path(@applicant)
    end
  end

end
