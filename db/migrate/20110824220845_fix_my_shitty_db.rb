class FixMyShittyDb < ActiveRecord::Migration
  def self.up
    add_column :blocks, :tint, :string
    add_column :blocks, :bint, :string
    remove_column :blocks, :int1
    remove_column :blocks, :int2
    remove_column :blocks, :txcnn
    remove_column :blocks, :bxcnn
  end

  def self.down
    remove_column :blocks, :tint
    remove_column :blocks, :bint
  end
end
