class ChangePeopleAccountIdToUuid < ActiveRecord::Migration
  def up
    change_column :people, :account_id, :binary, :limit => 16
  end

  def down
    change_column :people, :account_id, :integer
  end
end
