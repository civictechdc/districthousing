class AddDriverLicenseToPerson < ActiveRecord::Migration
  def change
    add_column :people, :driver_license_number, :string
    add_column :people, :driver_license_state, :string
  end
end
