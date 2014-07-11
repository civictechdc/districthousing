class CreateMailAddressesJoinTable < ActiveRecord::Migration
  def change
    create_join_table(:people, :addresses, table_name: :mail)
  end
end
