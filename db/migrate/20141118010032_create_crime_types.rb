class CreateCrimeTypes < ActiveRecord::Migration
  def change
    create_table :crime_types do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
  end
end
