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

  def field_names uri
    uri = URI.parse("http://192.241.132.194:8080/fields.json?pdf=#{uri}")
    response = Net::HTTP.get(uri)
    JSON.parse(response).map do |field_hash|
      field_hash["FieldName"]
    end
  end

  def fill_form form
    http_post_data = Hash.new
    http_post_data["pdf"] = form.uri
    http_post_data.deep_merge!(Resident.first.form_field_hash(field_names(form.uri)))

    fill_uri = URI.parse("http://192.241.132.194:8080/fill")
    Net::HTTP.post_form(fill_uri, http_post_data)
  end

  def generate_pdf_archive cart
    stringio = Zip::ZipOutputStream::write_buffer do |zio|
      cart.line_items.map(&:housing_form).each do |form|
        response = fill_form(form)
        zio.put_next_entry("#{form.name}.pdf")
        zio.write response.body
      end
    end
    stringio.rewind
    stringio.sysread
  end


end
