class RemoveAddressKeysFromPerson < ActiveRecord::Migration
  def change
    remove_column :people, :residence_id
    remove_column :people, :mail_id
  end
end
