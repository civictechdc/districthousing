class CreatePreviousSsns < ActiveRecord::Migration
  def change
    create_table :previous_ssns do |t|
      t.string :number
      t.integer :resident_id

      t.timestamps
    end
  end
end
