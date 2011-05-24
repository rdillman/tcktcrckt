class AddCnnToAlarm < ActiveRecord::Migration
  def self.up
    add_column :alarms, :cnn, :integer
  end

  def self.down
    remove_column :alarms, :cnn
  end
end
