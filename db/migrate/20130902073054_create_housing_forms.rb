class CreateHousingForms < ActiveRecord::Migration
  def change
    create_table :housing_forms do |t|
      t.string :name
      t.string :uri

      t.timestamps
    end
  end
end
