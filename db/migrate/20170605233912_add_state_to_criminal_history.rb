class AddStateToCriminalHistory < ActiveRecord::Migration
  def change
    add_column :criminal_histories, :state, :string
  end
end
