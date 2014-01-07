class FormPickerController < ApplicationController
  def index
    @cart = current_cart
    @current_form_ids = @cart.line_items.map(&:housing_form_id)
    @housing_forms = HousingForm.all.reject{|x| @current_form_ids.include?(x.id)}
    @resident = @cart.resident

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @housing_forms }
    end
  end

  def download
    send_data generate_pdf_archive(current_cart),
      filename: 'housingforms.zip',
      type: 'application/zip'
  end
end
