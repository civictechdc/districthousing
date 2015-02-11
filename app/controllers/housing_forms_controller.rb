class HousingFormsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_housing_form, only: [:show, :edit, :update, :destroy, :download]
  before_action :set_applicant, only: [:show, :index, :download]

  # GET /housing_forms
  def index
    @housing_forms = HousingForm.all
    @housing_forms_available = HousingForm.where.not(path: nil)
    @housing_forms_unavailable = HousingForm.where(path: nil)

    respond_to do |format|
      format.html
      format.json { render :json => @housing_forms }
    end
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
    if @housing_form = HousingForm.create(housing_form_params) do |h|
      if uploaded_file
        h.path = write_file(uploaded_file).to_s
        h.name = uploaded_file.original_filename if h.name.blank?
      end
    end
      redirect_to @housing_form, notice: 'Housing form was successfully created.'
    else
      render :new, alert: "Error: #{@housing_form.errors.messages}"
    end
  end

  # PATCH/PUT /housing_forms/1
  def update
    if uploaded_file
      @housing_form.path = write_file(uploaded_file, @housing_form.path).to_s
      @housing_form.save
    end

    if @housing_form.update(housing_form_params) do |h|
    end
      redirect_to @housing_form, notice: 'Housing form was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /housing_forms/1
  def destroy
    delete_file(@housing_form.path)
    @housing_form.destroy
    redirect_to housing_forms_url, notice: 'Housing form was successfully destroyed.'
  end

  def download
    filled_file = OutputPDF.new(@housing_form, @applicant).to_file
    download_filename = "#{@applicant}-#{@housing_form.name}.pdf"
    download_filename = slugify(download_filename)
    send_file(filled_file.path,
              type: 'application/pdf',
              filename: download_filename)
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

    def set_applicant
      @applicant = current_applicant || sample_applicant
    end

    def write_file uploaded_file, path=nil
      if path.blank?
        path = make_tempname
      end
      call_file_write(path, uploaded_file.read)
      path
    end

    def uploaded_file
      params[:housing_form][:new_form]
    end

    # This method exists so we don't have to stub out File#write
    def call_file_write path, contents
      File.open(path, "wb") do |file|
        file.write(contents)
      end
    end

    # This method exists so we don't have to stub out Dir::Tmpname.make_tmpname
    def make_tempname
      Rails.root.join( "public", "forms", Dir::Tmpname.make_tmpname("", ".pdf"))
    end

    # This method exists so we don't have to stub out File.delete
    def delete_file path
      File.delete(path)
    end

    def slugify filename
      filename.gsub(/[^0-9A-Za-z.\-]/, '_')
    end
end
