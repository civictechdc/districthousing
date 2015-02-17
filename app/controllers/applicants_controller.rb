class ApplicantsController < ApplicationController

  def new
  end

  def create
    @applicant = Applicant.new

    @applicant.identity = add_a_new_person(@applicant)
    @applicant.identity.first_name = params[:first_name]
    @applicant.identity.last_name = params[:last_name]
    @applicant.user = current_user

    success = false

    Applicant.transaction do
      params[:household_member_count].to_i.times do
        @applicant.household_members << add_new_household_member(@applicant)
      end
      params[:residence_count].to_i.times do
        @applicant.residences << add_new_residence(@applicant)
      end
      params[:income_count].to_i.times do
        add_new_income(@applicant)
      end
      params[:employment_count].to_i.times do
        @applicant.identity.employments << add_new_employment(@applicant)
      end
      params[:contact_count].to_i.times do
        @applicant.identity.contacts << add_new_contact(@applicant)
      end
      success = @applicant.save
    end

    if success
      session[:current_applicant_id] = @applicant.id
      redirect_to edit_identity_path(@applicant)
    else
      render :new
    end
  end

  def show
    @housing_forms = HousingForm.where.not(path: nil)
    @applicant = Applicant.find(params[:id])
    session[:current_applicant_id] = @applicant.id
    assign_current_applicant
  end

  def update
    @applicant = current_applicant
    @applicant.update_attributes(params[:applicant])

    respond_to do |format|
      format.html { redirect_to apply_path }
    end
  end

  def destroy
    applicant = Applicant.find(params[:id])
    applicant.destroy if applicant
    redirect_to root_path
  end

  private

  def add_new_employment applicant
    Employment.create do |e|
      e.address = Address.create
    end
  end

  def add_new_income applicant
    Income.create do |i|
      i.income_type = "salary"
      i.person = applicant.identity
    end
  end

  def add_new_residence applicant
    Residence.create do |r|
      r.address = Address.create
      r.landlord = add_a_new_person(applicant)
    end
  end

  def add_new_household_member applicant
    HouseholdMember.create do |h|
      h.person = add_a_new_person(applicant)
    end
  end

  def add_new_contact applicant
    Contact.create do |c|
      c.contact = add_a_new_person(applicant)
    end
  end

  def add_a_new_person applicant
    Person.create do |p|
      p.applicant = applicant
      p.mail_address = Address.create
    end
  end
end
