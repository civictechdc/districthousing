module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # I'm surprised this doesn't seem to be built in.
  def edit_path model
    case model
    when HouseholdMember
      edit_applicant_household_member_path(@applicant, model)
    when Residence
      edit_applicant_residence_path(@applicant, model)
    when Income
      edit_applicant_income_path(@applicant, model)
    when Employment
      edit_applicant_employment_path(@applicant, model)
    when CriminalHistory
      edit_applicant_criminal_history_path(@applicant, model)
    when Contact
      edit_applicant_contact_path(@applicant, model)
    else
      "#"
    end
  end

  def new_path collection
    # This gives us the class of the collection items, even if the collection
    # is empty.
    case collection.class.to_s.deconstantize.to_sym
    when :HouseholdMember
      new_applicant_household_member_path(@applicant)
    when :Residence
      new_applicant_residence_path(@applicant)
    when :Income
      new_applicant_income_path(@applicant)
    when :Employment
      new_applicant_employment_path(@applicant)
    when :CriminalHistory
      new_applicant_criminal_history_path(@applicant)
    when :Contact
      new_applicant_contact_path(@applicant)
    else
      "#"
    end
  end

  def basic_path model
    case model
    when HouseholdMember
      applicant_household_member_path(@applicant, model)
    when Residence
      applicant_residence_path(@applicant, model)
    when Income
      applicant_income_path(@applicant, model)
    when Employment
      applicant_employment_path(@applicant, model)
    when CriminalHistory
      applicant_criminal_history_path(@applicant, model)
    when Contact
      applicant_contact_path(@applicant, model)
    else
      "#"
    end
  end
end
