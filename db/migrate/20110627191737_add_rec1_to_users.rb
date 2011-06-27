class AddRec1ToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :rec1, :string
    add_column :users, :rec2, :string
    add_column :users, :rec3, :string
  end

  def self.down
    remove_column :users, :rec1
    remove_column :users, :rec2
    remove_column :users, :rec3
  end
end
