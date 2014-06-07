class AddApplicantIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :applicant_id, :integer
  end
end
