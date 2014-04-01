class RenameResidentToPerson < ActiveRecord::Migration
  def self.up
    rename_table :residents, :people
  end

  def self.down
    rename_table :people, :residents
  end
end
