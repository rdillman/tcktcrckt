class AddBlockIdToClean < ActiveRecord::Migration
  def self.up
    add_column :cleans, :block_id, :integer
  end

  def self.down
    remove_column :cleans, :block_id
  end
end
