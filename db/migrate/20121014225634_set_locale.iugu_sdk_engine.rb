# This migration comes from iugu_sdk_engine (originally 20120612141130)
class SetLocale < ActiveRecord::Migration
  def change
    User.where(:locale => nil).update_all("locale = 'en'")
  end

end
