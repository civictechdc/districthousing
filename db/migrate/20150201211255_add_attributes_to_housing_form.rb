class AddAttributesToHousingForm < ActiveRecord::Migration
  def change
    add_column :housing_forms, :latitude, :float
    add_column :housing_forms, :longitude, :float
  end
end
