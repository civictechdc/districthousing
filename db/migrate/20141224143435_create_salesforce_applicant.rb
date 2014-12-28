class CreateSalesforceApplicant < ActiveRecord::Migration
  def change
    create_table :salesforce_applicants do |t|
      t.integer :applicant_id
      t.string :name
    end
  end
end
