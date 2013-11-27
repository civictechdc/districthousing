class HousingFormsController < ApplicationController
  # GET /housing_forms
  # GET /housing_forms.json
  def index
    @housing_forms = HousingForm.all
    @cart = current_cart

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @housing_forms }
    end
  end

  # GET /housing_forms/1
  # GET /housing_forms/1.json
  def show
    @housing_form = HousingForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @housing_form }
    end
  end

  # GET /housing_forms/new
  # GET /housing_forms/new.json
  def new
    @housing_form = HousingForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @housing_form }
    end
  end

  # GET /housing_forms/1/edit
  def edit
    @housing_form = HousingForm.find(params[:id])
  end

  # POST /housing_forms
  # POST /housing_forms.json
  def create
    @housing_form = HousingForm.new(params[:housing_form])

    respond_to do |format|
      if @housing_form.save
        format.html { redirect_to @housing_form, notice: 'Housing form was successfully created.' }
        format.json { render json: @housing_form, status: :created, location: @housing_form }
      else
        format.html { render action: "new" }
        format.json { render json: @housing_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /housing_forms/1
  # PUT /housing_forms/1.json
  def update
    @housing_form = HousingForm.find(params[:id])

    respond_to do |format|
      if @housing_form.update_attributes(params[:housing_form])
        format.html { redirect_to @housing_form, notice: 'Housing form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @housing_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /housing_forms/1
  # DELETE /housing_forms/1.json
  def destroy
    @housing_form = HousingForm.find(params[:id])
    @housing_form.destroy

    respond_to do |format|
      format.html { redirect_to housing_forms_url }
      format.json { head :no_content }
    end
  end
end
