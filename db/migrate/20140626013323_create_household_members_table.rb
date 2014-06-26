class CreateHouseholdMembersTable < ActiveRecord::Migration
  def change
    create_table :household_members do |t|
      t.references :applicant, index: true
      t.references :person, index: true
      t.string :relationship
    end
  end
end
