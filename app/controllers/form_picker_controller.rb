class FormPickerController < ApplicationController
  def index
    @applicant = current_applicant

    respond_to do |format|
      format.html
    end
  end

  def download
    send_data generate_pdf_archive(HousingForm.all, current_applicant),
      filename: 'housingforms.zip',
      type: 'application/zip'
  end
end
