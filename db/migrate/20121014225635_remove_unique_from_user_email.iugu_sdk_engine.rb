# This migration comes from iugu_sdk_engine (originally 20120613173114)
class RemoveUniqueFromUserEmail < ActiveRecord::Migration
  def up
    remove_index "users", :name => "index_users_on_email"
    add_index "users", ["email"], :name => "index_users_on_email"
  end

  def down
    remove_index "users", :name => "index_users_on_email"
    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  end
end