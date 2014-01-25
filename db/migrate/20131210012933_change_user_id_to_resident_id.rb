class ChangeUserIdToResidentId < ActiveRecord::Migration
  def change
    rename_column :carts, :user_id, :resident_id
  end
end
