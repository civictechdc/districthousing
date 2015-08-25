class RemoveLatLongFromHousingForms < ActiveRecord::Migration
  def change
    remove_column :housing_forms, :lat
    remove_column :housing_forms, :long
  end
end
