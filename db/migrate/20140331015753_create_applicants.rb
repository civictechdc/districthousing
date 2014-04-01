class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.integer :self_person_id

      t.timestamps
    end
  end
end
