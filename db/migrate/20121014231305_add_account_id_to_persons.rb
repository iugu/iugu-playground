class AddAccountIdToPersons < ActiveRecord::Migration
  def up
    add_column :persons, :account_id, :integer
  end

  def down
    remove_column :persons, :account_id
  end
end
