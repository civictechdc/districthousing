class AddRentToResidences < ActiveRecord::Migration
  def change
    add_column :residences, :rent, :integer
  end
end
