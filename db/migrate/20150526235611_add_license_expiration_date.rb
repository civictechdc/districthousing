class AddLicenseExpirationDate < ActiveRecord::Migration
  def change
    add_column :people, :driver_license_exp_date, :datetime
  end
end
