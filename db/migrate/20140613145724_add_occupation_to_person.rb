class AddOccupationToPerson < ActiveRecord::Migration
  def change
    add_column :people, :occupation, :string
  end
end
