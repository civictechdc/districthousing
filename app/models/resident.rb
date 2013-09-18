require 'zip/zip'
require 'net/http'

class Resident < ActiveRecord::Base
  attr_accessible :dob, :first_name, :gender, :last_name, :middle_name, :res_apt, :res_city, :res_state, :res_street_address, :res_zip, :ssn

  belongs_to :user

  def instance_variable_string_hash *variable_names
    h = Hash.new
    variable_names.each do |attr|
      puts attr
      h["#{attr}"] = instance_variable_get("@#{attr}").to_s
    end
    h
  end

  def attributes_hash
    instance_variable_string_hash self.class.accessible_attributes
  end

  def generate_pdf_archive
    stringio = Zip::ZipOutputStream::write_buffer do |zio|
      HousingForm.all.each do |form|
        uri = URI.parse("http://192.241.132.194:8080/fill")
        http_post_data = attributes
        http_post_data["pdf"] = form.uri
        logger.debug http_post_data.inspect
        response = Net::HTTP.post_form(uri, http_post_data)
        zio.put_next_entry("#{form.name}.pdf")
        zio.write response.body
      end
    end
    stringio.rewind
    stringio.sysread
  end

end
