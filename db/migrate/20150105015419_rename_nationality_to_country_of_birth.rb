class RenameNationalityToCountryOfBirth < ActiveRecord::Migration
  def change
    rename_column :people, :nationality, :country_of_birth
  end
end
