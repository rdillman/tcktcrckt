class FuckYouPointlessTables < ActiveRecord::Migration
  def self.up
      drop_table :xions
      drop_table :points
    end
  end

  def self.down
  end
end
