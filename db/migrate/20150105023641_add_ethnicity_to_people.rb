class AddEthnicityToPeople < ActiveRecord::Migration
  def change
    add_column :people, :ethnicity, :string
  end
end
