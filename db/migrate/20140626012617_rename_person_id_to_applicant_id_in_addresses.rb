class RenamePersonIdToApplicantIdInAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :person_id, :applicant_id
  end
end
