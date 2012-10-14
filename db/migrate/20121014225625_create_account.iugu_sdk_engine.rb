# This migration comes from iugu_sdk_engine (originally 20120528164634)
class CreateAccount < ActiveRecord::Migration
  def up
    create_table :accounts do |t|
      t.timestamps
    end
  end

  def down
    drop_table :accounts
  end
end
