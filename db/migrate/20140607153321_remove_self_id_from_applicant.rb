class RemoveSelfIdFromApplicant < ActiveRecord::Migration
  def change
    remove_column :applicants, :self_id
  end
end
