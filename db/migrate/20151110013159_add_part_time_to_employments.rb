class AddPartTimeToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :part_time, :boolean
  end
end
