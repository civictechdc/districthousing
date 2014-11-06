class PeopleController < ApplicationController
  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])

    if @person.update(params[:person])
      redirect_to @person.applicant
    else
      render :edit
    end
  end

  private

  def housing_form_params
    params[:person]
  end
end
