class CreateAlarms < ActiveRecord::Migration
  def self.up
    create_table :alarms do |t|
      t.string      :location
      t.string      :clean_time 
      t.string      :send_time
      t.references  :user
      t.references  :ct
    end
  end

  def self.down
    drop_table :alarms
  end
end
