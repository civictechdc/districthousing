class FormPickerController < ApplicationController
  def index
    @cart = current_cart
    @current_form_ids = @cart.line_items.map(&:housing_form_id)
    @housing_forms = HousingForm.all.reject{|x| @current_form_ids.include?(x.id)}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @housing_forms }
    end
  end

  def download
    if current_cart.resident.nil?
      redirect_to picker_url, notice: "Sorry! You have to choose a resident first."
      return
    end

    if current_cart.line_items.empty?
      redirect_to picker_url, notice: "Whoops! You need to select some housing forms."
      return
    end

    send_data generate_pdf_archive(current_cart),
      filename: 'housingforms.zip',
      type: 'application/zip'
  end
end
