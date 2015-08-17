class ContactsController < ApplicationController
  include ApplicantFormPage

  private

  def this_section
    :contacts
  end

  def first_item
    @applicant.contacts.first
  end

  def last_item
    @applicant.contacts.last
  end

  def make_new
    c = Contact.create
    c.applicant = @applicant
    c
  end

  def set_model
    @model = Contact.find(params[:id])
  end

  def model_params
    params.require(:contact).permit(
      :relationship,
      :contact_type,
      person_attributes: [
        :id,
        :dob,
        :first_name,
        :gender,
        :last_name,
        :middle_name,
        :res_apt,
        :ssn,
        :phone,
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
          :id,
          :street,
          :city,
          :state,
          :zip,
          :apt,
        ]
      ]
    )
  end

  def next_page
    find_next_page @applicant.contacts, @model, :edit_model
  end

  def edit_model item
    edit_applicant_contact_path(@applicant, item)
  end

  def front_of_next_section
    @applicant
  end

  def back_of_previous_section
    edit_applicant_identity_path(@applicant)
  end
end
