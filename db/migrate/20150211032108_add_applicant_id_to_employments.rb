class AddApplicantIdToEmployments < ActiveRecord::Migration
  def change
    change_table :employments do |t|
      t.references :applicant, index: true
    end
  end
end
