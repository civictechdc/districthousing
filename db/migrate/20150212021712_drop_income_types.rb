class DropIncomeTypes < ActiveRecord::Migration
  def change
    drop_table :income_types
    remove_column :incomes, :income_type_id
    add_column :incomes, :income_type, :string
  end
end
