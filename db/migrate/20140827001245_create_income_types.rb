class CreateIncomeTypes < ActiveRecord::Migration
  def change
    create_table :income_types do |t|
      t.string :name
      t.string :label
      t.boolean :active

      t.timestamps
    end
  end
end
