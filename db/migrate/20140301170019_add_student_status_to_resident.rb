class AddStudentStatusToResident < ActiveRecord::Migration
  def change
    add_column :residents, :student_status, :string
  end
end
