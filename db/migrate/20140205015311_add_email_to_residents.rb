class AddEmailToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :email, :string
  end
end
