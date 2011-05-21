class CreateStreets < ActiveRecord::Migration
  def self.up
    create_table :streets do |t|
      t.string :streetname
    end
    add_index :streets, :streetname 
  end

  def self.down
    drop_table :streets
  end
end
