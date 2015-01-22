module ApplicantFormPage
  extend ActiveSupport::Concern

  included do
    before_action :set_applicant
    before_action :set_model, only: [:edit, :update, :destroy]
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

  def update
    if @model.update(model_params)
      redirect_to next_page
    else
      redirect_to edit_model(@model), notice: 'Couldn\'t save.'
    end
  end

  def destroy
    @model.destroy
    redirect_to @applicant, notice: 'Residence removed', status: :see_other
  end

end
