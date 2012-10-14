# This migration comes from iugu_sdk_engine (originally 20120719162426)
class AddSubdomainToAccount < ActiveRecord::Migration
  def up
    add_column :accounts, :subdomain, :string
  end

  def down
    remove_column :accounts, :subdomain
  end
end
