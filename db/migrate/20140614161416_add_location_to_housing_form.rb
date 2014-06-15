class AddLocationToHousingForm < ActiveRecord::Migration
  def change
    add_column :housing_forms, :location, :string
  end
end
