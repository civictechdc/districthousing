class FormPickerController < ApplicationController
  def index
    @cart = current_cart
    @housing_forms = HousingForm.all.reject{|x| @cart.forms.include? x }
    @resident = @cart.resident
    @pdf_field_names = @cart.forms.map{ |form| field_names(form.uri) }.flatten.to_set
    unless @resident.nil?
      @still_needed = @resident.missing_attrs_for @pdf_field_names
      @unrecognized = @resident.unrecognized_fields_for @pdf_field_names
      @provided = @resident.form_field_hash @pdf_field_names
    end

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
