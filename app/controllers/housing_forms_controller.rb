class HousingFormsController < ApplicationController
  before_action :set_housing_form, only: [:show, :edit, :update, :destroy]

  # GET /housing_forms
  def index
    @housing_forms = HousingForm.all
  end

  # GET /housing_forms/1
  def show
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
    @housing_form = HousingForm.new(housing_form_params)

    if @housing_form.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_housing_form
      @housing_form = HousingForm.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def housing_form_params
      params[:housing_form]
    end
end
