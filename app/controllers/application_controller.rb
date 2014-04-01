class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def form_field_hash field_names, applicant
    result = Hash.new

    field_names.map(&:name).each do |field_name|
      begin
      result[field_name] = $field_name_translator.field( field_name, applicant )
      rescue Dragoman::MissingItemsError
      rescue Dragoman::NoMatchError
      end
    end

    result
  end

  def fill_form form, applicant
    http_post_data = form_field_hash(form.form_fields, applicant)
    destination_pdf = Tempfile.new(form.name)
    PDF_FORMS.fill_form form.uri, destination_pdf.path, http_post_data
    destination_pdf
  end

  def generate_pdf_archive cart
    stringio = Zip::ZipOutputStream::write_buffer do |zio|
      cart.forms.each do |form|
        filled_form = fill_form(form, cart.applicant)
        zio.put_next_entry(form.name)
        zio.write(filled_form.read)
        filled_form.unlink
      end
    end
    stringio.rewind
    stringio.sysread
  end

end
