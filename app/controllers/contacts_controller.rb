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
  binding.pry

  def set_model
    @model = Contact.find(params[:id])
  end

  def model_params
    params.require(:contact).permit(
      :relationship,
      person_attributes: [
        :id,
        :first_name,
        :last_name,
        :middle_name,
        :res_apt,
        :phone,
        :work_phone,
        :home_phone,
        :cell_phone,
        :preferred_phone,
        :email,
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

  # def selected_or_created_person
  #   if params[:person_id].blank?
  #     person = Person.new(
  #       first_name: params[:first_name],
  #       last_name: params[:last_name],
  #     )
  #     person.applicant = @applicant
  #     return person
  #   else
  #     return Person.find(params[:person_id])
  #   end
  # end

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
