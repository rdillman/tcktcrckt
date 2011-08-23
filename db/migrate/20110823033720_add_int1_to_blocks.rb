class AddInt1ToBlocks < ActiveRecord::Migration
  def self.up
    add_column :blocks, :int1, :string
    add_column :blocks, :int2, :string
  end

  def self.down
    remove_column :blocks, :int1
    remove_column :blocks, :int2
  end
end
