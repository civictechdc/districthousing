class AddUserRefToApplicants < ActiveRecord::Migration
  def change
    add_reference :applicants, :user, index: true
  end
end
