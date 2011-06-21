class AddTmpqryToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :tmpqry, :string
  end

  def self.down
    remove_column :users, :tmpqry
  end
end
