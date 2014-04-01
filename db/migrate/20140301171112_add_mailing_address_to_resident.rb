class AddMailingAddressToResident < ActiveRecord::Migration
  def change
    add_column :residents, :mail_street_address, :string
    add_column :residents, :mail_city, :string
    add_column :residents, :mail_state, :string
    add_column :residents, :mail_zip, :string
  end
end
