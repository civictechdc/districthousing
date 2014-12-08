class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :authenticate_user!
  before_action :assign_current_applicant

  private

  def assign_current_applicant
    @current_applicant = current_applicant
  end

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
      begin
        Applicant.find(session[:current_applicant_id])
      rescue ActiveRecord::RecordNotFound
        session.delete(:current_applicant_id)
      end
    else
      nil
    end
  end

  def sample_applicant
    User.find_by(role: User::USER_ROLES[:sample]).applicants.first
  end

  def find_next_page collection, current_item, edit_method
    my_index = collection.find_index(current_item)
    if params[:submit_direction] == "next"
      next_item = collection[my_index + 1]
      if next_item.nil?
        return front_of_next_section
      else
        return send(edit_method, next_item)
      end
    elsif params[:submit_direction] == "previous"
      if my_index - 1 < 0
        return back_of_previous_section
      else
        next_item = collection[my_index - 1]
        return send(edit_method, next_item)
      end
    else
      flash[:notice] = "Saved!"
      return send(edit_method, current_item)
    end
  end

end
