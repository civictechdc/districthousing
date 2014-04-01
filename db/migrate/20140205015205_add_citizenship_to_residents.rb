class AddCitizenshipToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :citizenship, :string
  end
end
