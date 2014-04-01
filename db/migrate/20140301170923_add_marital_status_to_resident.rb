class AddMaritalStatusToResident < ActiveRecord::Migration
  def change
    add_column :residents, :marital_status, :string
  end
end
