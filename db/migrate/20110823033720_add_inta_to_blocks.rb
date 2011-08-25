class AddInt1ToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :tint, :string
    add_column :blocks, :bint, :string
  end

  def self.down
    remove_column :blocks, :tint
    remove_column :blocks, :bint
  end
end
