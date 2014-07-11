class AddMailAddressIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :mail_address_id, :integer
  end
end
