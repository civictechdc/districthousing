class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :applicant, index: true
      t.references :person, index: true
      t.string :relationship
      t.timestamps
    end
  end
end
