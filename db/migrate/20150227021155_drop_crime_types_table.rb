class DropCrimeTypesTable < ActiveRecord::Migration
  def change
    drop_table :crime_types
  end
end
