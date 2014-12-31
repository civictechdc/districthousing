class SalesforceApplicantsController < ApplicationController
  before_action :set_salesforce_applicant, only: [:show, :edit, :update, :destroy]

  # GET /salesforce_applicants
  def index
    @salesforce_applicants = SalesforceApplicant.all
  end

  # GET /salesforce_applicants/1
  def show
  end

  # GET /salesforce_applicants/new
  def new
    @salesforce_applicant = SalesforceApplicant.new
  end

  # GET /salesforce_applicants/1/edit
  def edit
  end

  # POST /salesforce_applicants
  def create
    @salesforce_applicant = SalesforceApplicant.new(salesforce_applicant_params)

    if @salesforce_applicant.save
      redirect_to @salesforce_applicant, notice: 'Salesforce applicant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /salesforce_applicants/1
  def update
    if @salesforce_applicant.update(salesforce_applicant_params)
      redirect_to @salesforce_applicant, notice: 'Salesforce applicant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /salesforce_applicants/1
  def destroy
    @salesforce_applicant.destroy
    redirect_to salesforce_applicants_url, notice: 'Salesforce applicant was successfully destroyed.'
  end

  def sync
    pull_from_salesforce
    redirect_to home_index_url, notice: 'Refreshed from salesforce.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salesforce_applicant
      @salesforce_applicant = SalesforceApplicant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def salesforce_applicant_params
      params.require(:salesforce_applicant).permit(:name, :applicant_id)
    end

    def intakes
      unless defined? Intake__c
        c = Databasedotcom::Client.new("config/databasedotcom.yml")
        c.authenticate(
          username: YAML.load_file("config/databasedotcom.yml")["username"],
          password: Rails.application.secrets.salesforce_password
        )
        c.materialize("Intake__c")
      end
      Intake__c.all
    end

    def pull_from_salesforce
      intakes.each do |intake|
        sfa = SalesforceApplicant.find_or_create_by(name: intake.Name)
        if sfa.applicant.nil?
          sfa.applicant = current_user.applicants.build
        end
        sfa.merge intake
        sfa.save
      end
    end
end
