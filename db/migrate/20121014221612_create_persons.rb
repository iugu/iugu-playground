class CreatePersons < ActiveRecord::Migration
  def up
    create_table :persons do |t|
      t.column :name, :string
      t.column :age, :integer
      t.column :notes, :string
      t.timestamps
    end
  end

  def down
    drop_table :persons
  end
end
