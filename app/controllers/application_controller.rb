class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!

  private

  def generate_pdf_archive forms, applicant
    stringio = Zip::OutputStream::write_buffer do |zio|
      forms.each do |form|
        filled_form = OutputPDF.new(form, applicant).to_file
        zio.put_next_entry(form.name)
        zio.write(filled_form.read)
        filled_form.unlink
      end
    end
    stringio.rewind
    stringio.sysread
  end

  def current_applicant
    if user_signed_in?
      current_user.applicants.first_or_create.tap do |applicant|
        applicant.create_identity if applicant.identity.nil?
        applicant.save
      end
    else
      sample_applicant
    end
  end

  def sample_applicant
    User.find_by(role: User::USER_ROLES[:sample]).applicants.first
  end

end
