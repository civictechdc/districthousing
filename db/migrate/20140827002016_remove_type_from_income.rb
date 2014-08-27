class RemoveTypeFromIncome < ActiveRecord::Migration
  def change
    remove_column :incomes, :type
  end
end
