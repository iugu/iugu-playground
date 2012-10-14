# This migration comes from iugu_sdk_engine (originally 20120530114709)
class RemoveUserIdFromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :user_id
  end

  def down
    add_column :accounts, :user_id, :integer
  end
end
