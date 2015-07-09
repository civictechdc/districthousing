class AddCurrentToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :current, :boolean
  end
end
