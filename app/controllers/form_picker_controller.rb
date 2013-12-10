class FormPickerController < ApplicationController
  def index
    @housing_forms = HousingForm.all
    @cart = current_cart
    @resident = Resident.find(@cart.user_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @housing_forms }
    end
  end
end
