class RenameAddressColumns < ActiveRecord::Migration
  def change
    rename_column :people, :residence, :residence_id
    rename_column :people, :mail, :mail_id
  end
end
