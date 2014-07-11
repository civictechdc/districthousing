class AddIdentityIdToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :identity_id, :integer
  end
end
