class RemoveTypeFromPerson < ActiveRecord::Migration
  def change
    remove_column :people, :type
  end
end
