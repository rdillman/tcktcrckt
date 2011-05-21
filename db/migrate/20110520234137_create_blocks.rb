class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.integer :cnn
      t.string  :streetname
      t.string  :suff
      t.integer :botl
      t.integer :topl
      t.integer :botr
      t.integer :topr
      t.integer :txcnn
      t.integer :bxcnn
      t.string  :nhood
      t.boolean :cleaned
      t.string  :nct

    end
  end

  def self.down
    drop_table :blocks
  end
end
