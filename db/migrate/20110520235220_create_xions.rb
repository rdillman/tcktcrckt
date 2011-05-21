class CreateXions < ActiveRecord::Migration
  def self.up
    create_table :xions do |t|
      t.integer :xcnn
      t.string :streetname

    end
    add_index :xions, :xcnn
    
  end

  def self.down
    drop_table :xions
  end
end
