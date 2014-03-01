class AddRaceToResident < ActiveRecord::Migration
  def change
    add_column :residents, :race, :string
  end
end
