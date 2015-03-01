class AddUpdatedLocallyToHousingForms < ActiveRecord::Migration
  def change
    add_column :housing_forms, :updated_locally, :boolean
  end
end
