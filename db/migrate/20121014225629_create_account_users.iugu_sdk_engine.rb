# This migration comes from iugu_sdk_engine (originally 20120529180814)
class CreateAccountUsers < ActiveRecord::Migration
  def up
    create_table :account_users do |t|
      t.column :account_id, :integer
      t.column :user_id, :integer
    end
  end

  def down
    drop_table :account_users
  end
end
