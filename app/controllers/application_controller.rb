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

  def fill_form form, resident
    http_post_data = resident.form_field_hash(form.form_fields)
    destination_pdf = Tempfile.new(form.name)
    PDF_FORMS.fill_form form.uri, destination_pdf.path, http_post_data
    destination_pdf
  end

  def generate_pdf_archive cart
    stringio = Zip::ZipOutputStream::write_buffer do |zio|
      cart.forms.each do |form|
        filled_form = fill_form(form, cart.resident)
        zio.put_next_entry(form.name)
        zio.write(filled_form.read)
        filled_form.unlink
      end
    end
    stringio.rewind
    stringio.sysread
  end

end
