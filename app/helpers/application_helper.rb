module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  # I'm surprised this doesn't seem to be built in.
  def edit_path model
    case model
    when HouseholdMember
      edit_household_member_path(model)
    when Residence
      edit_residence_path(model)
    when Income
      edit_income_path(model)
    when Employment
      edit_employment_path(model)
    when CriminalHistory
      edit_criminal_history_path(model)
    else
      "#"
    end
  end

  def new_path model
    case model.class.to_s.deconstantize.to_sym
    when :HouseholdMember
      new_household_member_path
    when :Residence
      new_residence_path
    when :Income
      new_income_path
    when :Employment
      new_employment_path
    when :CriminalHistory
      new_criminal_history_path
    else
      "#"
    end
  end
end
