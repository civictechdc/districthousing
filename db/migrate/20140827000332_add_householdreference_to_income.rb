class AddHouseholdreferenceToIncome < ActiveRecord::Migration
  def change
    add_column :incomes, :household_member_id, :integer
    add_index :incomes, :household_member_id
    add_column :incomes, :income_type_id, :integer
    add_index :incomes, :income_type_id

  end
end
