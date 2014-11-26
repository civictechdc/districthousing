class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.integer :person_id
      t.date :start_date
      t.date :end_date
      t.string :employer_name
      t.string :supervisor_name
      t.string :position
      t.integer :address_id
      t.string :phone

      t.timestamps
    end
  end
end
