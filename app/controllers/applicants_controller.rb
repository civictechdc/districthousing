class ApplicantsController < ApplicationController

  def new
  end

  def create
    @applicant = Applicant.new

    identity = Person.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
    )

    identity.applicant = @applicant

    @applicant.identity = identity
    @applicant.user = current_user
    @applicant.identity.mail_address = Address.new

    success = false

    Applicant.transaction do
      success = @applicant.save
      success = identity.save && success
    end

    if success
      redirect_to @applicant
    else
      render :new
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
    session[:current_applicant_id] = @applicant.id
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
end
