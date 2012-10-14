# This migration comes from iugu_sdk_engine (originally 20120529162901)
class AddBirthdateAndNameToUser < ActiveRecord::Migration

  def up
    add_column :users, :birthdate, :date
    add_column :users, :name, :string
  end

  def down
    remove_column :users, :birthdate
    remove_column :users, :name
  end
end
