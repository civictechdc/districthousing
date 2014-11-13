class AddBirthLocationToPerson < ActiveRecord::Migration
  def change
    add_column :people, :state_of_birth, :string
    add_column :people, :city_of_birth, :string
  end
end
