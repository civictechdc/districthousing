class AddMorePhoneNumbersToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :work_phone, :string
    add_column :residents, :home_phone, :string
    add_column :residents, :cell_phone, :string
  end
end
