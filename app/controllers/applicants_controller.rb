class ApplicantsController < ApplicationController

  def new
  end

  def create
    @applicant = Applicant.new

    @applicant.identity = Person.new(
      first_name: params[:first_name],
      last_name: params[:last_name]
    )

    @applicant.user = current_user

    @applicant.identity.mail_address = Address.new

    if @applicant.save
      redirect_to home_index_path
    else
      render :new
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  def update
    @applicant = current_applicant
    @applicant.update_attributes(params[:applicant])

    respond_to do |format|
      format.html { redirect_to apply_path }
    end
  end

end
