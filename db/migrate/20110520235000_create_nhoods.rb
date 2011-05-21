class CreateNhoods < ActiveRecord::Migration
  def self.up
    create_table :nhoods do |t|
      t.string :nhood

    end
    add_index :nhoods, :nhood
  end

  def self.down
    drop_table :nhoods
  end
end
