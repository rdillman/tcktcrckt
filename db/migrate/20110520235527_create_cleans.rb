class CreateCleans < ActiveRecord::Migration
  def self.up
    create_table :cleans do |t|
      t.integer :cnn
      t.string  :side
      t.string  :wday
      t.string  :start
      t.string  :stop
      t.string  :boolyuns
      t.string  :dir
      t.string  :nct
      t.integer :ct_id
    end
    add_index :cleans, :cnn
    
  end

  def self.down
    drop_table :cleans
  end
end
