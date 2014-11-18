class CreateCriminalHistories < ActiveRecord::Migration
  def change
    create_table :criminal_histories do |t|
      t.integer :person_id
      t.integer :crime_type_id
      t.string :description
      t.date :year

      t.timestamps
    end
  end
end
