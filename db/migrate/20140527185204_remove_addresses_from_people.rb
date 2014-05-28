class RemoveAddressesFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :mail_street_address
    remove_column :people, :mail_city
    remove_column :people, :mail_state
    remove_column :people, :mail_zip
    remove_column :people, :mail_zip

    add_column :people, :residence, :integer

    remove_column :people, :res_street_address
    remove_column :people, :res_city
    remove_column :people, :res_state
    remove_column :people, :res_zip
    remove_column :people, :res_apt

    add_column :people, :mail, :integer
  end
end
