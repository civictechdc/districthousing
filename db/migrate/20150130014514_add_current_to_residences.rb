class AddCurrentToResidences < ActiveRecord::Migration
  def change
    add_column :residences, :current, :boolean
  end
end
