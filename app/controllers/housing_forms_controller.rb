class HousingFormsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_housing_form, only: [:show, :edit, :update, :destroy, :download]

  # GET /housing_forms
  def index
    @housing_forms = HousingForm.all

    respond_to do |format|
      format.html
      format.json { render :json => @housing_forms }
    end
  end

  # GET /housing_forms/1
  def show
    @applicant = current_applicant || sample_applicant
  end

  # GET /housing_forms/new
  def new
    @housing_form = HousingForm.new
  end

  # GET /housing_forms/1/edit
  def edit
  end

  # POST /housing_forms
  def create
    uploaded_file = params[:housing_form][:new_form]
    new_file_path = Rails.root.join("public", "forms", uploaded_file.original_filename)

    File.open(new_file_path, "wb") do |file|
      file.write(uploaded_file.read)
    end

    @housing_form = HousingForm.create(uri: new_file_path.to_s)
    if @housing_form
      redirect_to @housing_form, notice: 'Housing form was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /housing_forms/1
  def update
    if @housing_form.update(housing_form_params)
      redirect_to @housing_form, notice: 'Housing form was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /housing_forms/1
  def destroy
    @housing_form.destroy
    redirect_to housing_forms_url, notice: 'Housing form was successfully destroyed.'
  end

  def download
    filled_file = OutputPDF.new(@housing_form, current_applicant || sample_applicant).to_file
    send_file(filled_file.path,
             type: 'application/pdf',
             filename: @housing_form.name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_housing_form
      @housing_form = HousingForm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def housing_form_params
      params.require(:housing_form).permit(
        :name,
        :location,
        :lat,
        :long,
      )
    end
end
