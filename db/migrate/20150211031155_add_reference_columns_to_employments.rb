class AddReferenceColumnsToEmployments < ActiveRecord::Migration
  def change
    change_table :employments do |t|
      t.references :person, index: true
      t.references :address, index: true
    end
  end
end