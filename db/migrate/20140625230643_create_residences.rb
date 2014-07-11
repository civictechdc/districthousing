class CreateResidences < ActiveRecord::Migration
  def change
    create_table :residences do |t|
      t.references :applicant, index: true
      t.references :address, index: true
      t.date :start
      t.date :end
      t.string :reason
      t.references :landlord, index: true

      t.timestamps
    end
  end
end
