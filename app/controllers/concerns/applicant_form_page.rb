module ApplicantFormPage
  extend ActiveSupport::Concern

  included do
    before_action :set_applicant
    before_action :set_model, only: [:edit, :update, :destroy]
    before_action :set_next_and_previous_section_paths
  end

  def sections
    [
      :identity,
      :household_members,
      :residences,
      :employments,
      :incomes,
      :criminal_histories,
      :contacts
    ]
  end

  def section_front_path section
    send(section.to_s + "_front_path")
  end

  def section_back_path section
    send(section.to_s + "_back_path")
  end

  def set_next_and_previous_section_paths
    @active_section = this_section

    my_index = sections.find_index(this_section)

    next_section = sections[my_index + 1]
    if next_section
      @next_section_path = section_front_path(next_section)
    else
      # Done with the form, back to the summary
      @next_section_path = applicant_path(@applicant)
    end

    if my_index > 0
      previous_section = sections[my_index - 1]
      if previous_section
        @previous_section_path = section_back_path(previous_section)
      end
    end
  end

  def set_applicant
    @applicant = Applicant.find(params[:applicant_id])
  end

  def edit
  end

  def new
    @model = make_new

    if @model.save
      redirect_to edit_model(@model)
    else
      flash.alert = "Error: #{@applicant.errors.messages}"
      redirect_to @applicant
    end
  end

  def front
    f = first_item
    if f.nil?
      render :empty
    else
      redirect_to edit_model(f)
    end
  end

  def back
    l = last_item
    if l.nil?
      render :empty
    else
      redirect_to edit_model(l)
    end
  end

  def update
    if @model.update(model_params)
      redirect_to next_page
    else
      redirect_to edit_model(@model), alert: "Couldn't save: #{@model.errors.full_messages.join(" ")}"
    end
  end

  def destroy
    @model.destroy
    redirect_to @applicant, notice: 'Item removed', status: :see_other
  end

  def find_next_page collection, current_item, edit_method
    my_index = collection.find_index(current_item)
    if params[:submit_direction] == "next"
      next_item = collection[my_index + 1]
      if next_item.nil?
        return @next_section_path
      else
        return send(edit_method, next_item)
      end
    elsif params[:submit_direction] == "previous"
      if my_index - 1 < 0
        return @previous_section_path
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
