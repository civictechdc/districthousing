class ApplicantsHousingForms < ActiveRecord::Migration
  def change
  	create_table :applicants_housing_forms, :id => false do |t|
      t.integer :applicant_id
      t.integer :housing_form_id
    end
  end
end
