require 'zip'

class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def form_field_hash field_names, applicant
    result = Hash.new

    field_names.map(&:name).each do |field_name|
      begin
      result[field_name] = applicant.field(field_name)
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

  def generate_pdf_archive forms, applicant
    stringio = Zip::OutputStream::write_buffer do |zio|
      forms.each do |form|
        filled_form = fill_form(form, applicant)
        zio.put_next_entry(form.name)
        zio.write(filled_form.read)
        filled_form.unlink
      end
    end
    stringio.rewind
    stringio.sysread
  end

  def current_applicant
    current_user.applicants.first
  end

end
