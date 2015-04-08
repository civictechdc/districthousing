class AddRemoteIdToHousingForms < ActiveRecord::Migration
  def change
    add_column :housing_forms, :remote_id, :integer
  end
end
