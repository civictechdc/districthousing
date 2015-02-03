class ChangeUriToPathHousingForm < ActiveRecord::Migration
  def change
    rename_column :housing_forms, :uri, :path
  end
end
