class AddValcodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :valcode, :integer
  end

  def self.down
    remove_column :users, :valcode
  end
end
