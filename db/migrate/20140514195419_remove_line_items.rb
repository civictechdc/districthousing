class RemoveLineItems < ActiveRecord::Migration
  def change
    drop_table :line_items
  end
end
