class AddLatLongToHousingForm < ActiveRecord::Migration
  def change
    add_column :housing_forms, :lat, :float
    add_column :housing_forms, :long, :float
  end
end
