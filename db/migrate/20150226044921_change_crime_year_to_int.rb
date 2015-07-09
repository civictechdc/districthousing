class ChangeCrimeYearToInt < ActiveRecord::Migration
  def up
    change_column :criminal_histories, :year, :integer
  end

  def down
    change_column :criminal_histories, :year, :date
  end
end
