class RenameCartsPersonId < ActiveRecord::Migration
  def up
    rename_column :carts, :person_id, :applicant_id
  end

  def down
    rename_column :carts, :applicant_id, :person_id
  end
end
