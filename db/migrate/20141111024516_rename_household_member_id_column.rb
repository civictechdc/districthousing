class RenameHouseholdMemberIdColumn < ActiveRecord::Migration
  def change
    rename_column :incomes, :household_member_id, :person_id
  end
end
