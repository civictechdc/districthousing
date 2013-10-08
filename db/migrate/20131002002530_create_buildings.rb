class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :email
      t.string :fax

      t.timestamps
    end
  end
end
