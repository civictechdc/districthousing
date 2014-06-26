class CreateIdentityJoinTable < ActiveRecord::Migration
  def change
    create_join_table :applicants, :people, table_name: :identities do |t|
      # t.index [:applicant_id, :person_id]
      # t.index [:person_id, :applicant_id]
    end
  end
end
