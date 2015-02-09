class AddIntervalToIncome < ActiveRecord::Migration
  def change
    add_column :incomes, :interval, :string
  end
end
