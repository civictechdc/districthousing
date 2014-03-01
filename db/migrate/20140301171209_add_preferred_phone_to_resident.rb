class AddPreferredPhoneToResident < ActiveRecord::Migration
  def change
    add_column :residents, :preferred_phone, :string
  end
end
