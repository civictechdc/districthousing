class RenameResidentColumns < ActiveRecord::Migration
  def up
    rename_column :aliases, :resident_id, :person_id
    rename_column :carts, :resident_id, :person_id
    rename_column :previous_ssns, :resident_id, :person_id
  end

  def down
    rename_column :aliases, :person_id, :resident_id
    rename_column :carts, :person_id, :resident_id
    rename_column :previous_ssns, :person_id, :resident_id
  end
end
