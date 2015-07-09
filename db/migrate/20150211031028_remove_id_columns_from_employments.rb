class RemoveIdColumnsFromEmployments < ActiveRecord::Migration
  def change
    remove_column :employments, :address_id
    remove_column :employments, :person_id
  end
end
