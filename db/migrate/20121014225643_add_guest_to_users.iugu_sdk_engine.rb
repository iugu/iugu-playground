# This migration comes from iugu_sdk_engine (originally 20120803172545)
class AddGuestToUsers < ActiveRecord::Migration
  def up
    add_column :users, :guest, :boolean
  end

  def down
    remove_column :users, :guest
  end
end
