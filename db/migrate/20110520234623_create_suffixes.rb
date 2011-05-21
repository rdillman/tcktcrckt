class CreateSuffixes < ActiveRecord::Migration
  def self.up
    create_table :suffixes do |t|
      t.string :suff
      t.string :alias
    end
    
  end

  def self.down
    drop_table :suffixes
  end
end
