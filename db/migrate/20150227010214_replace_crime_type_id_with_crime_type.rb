class ReplaceCrimeTypeIdWithCrimeType < ActiveRecord::Migration
  def change
    remove_column :criminal_histories, :crime_type_id
    add_column :criminal_histories, :crime_type, :string
  end
end
