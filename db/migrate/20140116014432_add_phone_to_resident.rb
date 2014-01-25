class AddPhoneToResident < ActiveRecord::Migration
  def change
    add_column :residents, :phone, :string
  end
end
