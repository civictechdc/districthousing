class ApplicantsController < ApplicationController

  def create
    @applicant = Applicant.new

    @applicant.identity = Person.new
    @applicant.identity.mail_address = Address.new

    if @applicant.save
      redirect_to @applicant
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
