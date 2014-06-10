class RemovePreferredPhoneFromPeople < ActiveRecord::Migration
  def change
    remove_column :people, :preferred_phone, :string
  end
end
