class AddValphoneToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :valphone, :string
  end

  def self.down
    remove_column :users, :valphone
  end
end
