# This migration comes from iugu_sdk_engine (originally 20120705202827)
class AddRolesToUserInvitations < ActiveRecord::Migration
  def up
    add_column :user_invitations, :roles, :string
  end
  def down
    remove_column :user_invitations, :roles
  end
end
