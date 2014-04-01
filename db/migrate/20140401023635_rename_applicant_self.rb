class RenameApplicantSelf < ActiveRecord::Migration
  def up
    rename_column :applicants, :self_person_id, :self_id
  end

  def down
    rename_column :applicants, :self_id, :self_person_id
  end
end
