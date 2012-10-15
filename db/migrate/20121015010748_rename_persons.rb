class RenamePersons < ActiveRecord::Migration
  def up
    rename_table :persons, :people
  end

  def down
    rename_table :people, :persons
  end
end
