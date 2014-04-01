class AddNationalityToResidents < ActiveRecord::Migration
  def change
    add_column :residents, :nationality, :string
  end
end
