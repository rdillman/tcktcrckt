class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.integer  :cnn
      t.float    :lat
      t.float    :lng

    end
    add_index :points, :cnn
    
  end

  def self.down
    drop_table :points
  end
end
