require 'zip/zip'
require 'net/http'

class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :resident

  attr_accessible :resident_id

  # Prevent duplicates of the same housing from from being added to the cart
  def add_housing_form(housing_form_id)
    current_item = line_items.find_by_housing_form_id(housing_form_id)
    if ! current_item
      current_item = line_items.build(housing_form_id: housing_form_id)
    end
    current_item
  end

  def field_names uri
    uri = URI.parse("http://192.241.132.194:8080/fields.json?pdf=#{uri}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def fill_form form
    uri = URI.parse("http://192.241.132.194:8080/fill")
    http_post_data = Hash.new
    http_post_data["pdf"] = form.uri
    http_post_data.deep_merge!(Resident.first.form_field_hash(field_names(form.uri)))
    Net::HTTP.post_form(uri, http_post_data)
  end

  def generate_pdf_archive
    stringio = Zip::ZipOutputStream::write_buffer do |zio|
      line_items.map(&:housing_form).each do |form|
        response = fill_form(form)
        zio.put_next_entry("#{form.name}.pdf")
        zio.write response.body
      end
    end
    stringio.rewind
    stringio.sysread
  end

end
