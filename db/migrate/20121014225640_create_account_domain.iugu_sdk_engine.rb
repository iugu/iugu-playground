# This migration comes from iugu_sdk_engine (originally 20120716145846)
class CreateAccountDomain < ActiveRecord::Migration
  def up
    create_table :account_domains do |t|
      t.column :account_id, :integer
      t.column :url, :string
      t.column :verified, :boolean
      t.column :primary, :boolean
    end
  end

  def down
    drop_table :account_domains
  end
end