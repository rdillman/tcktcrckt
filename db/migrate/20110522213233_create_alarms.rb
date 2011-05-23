class CreateAlarms < ActiveRecord::Migration
  def self.up
    create_table :alarms do |t|
      t.string      :location
      t.string    :clean_time 
      t.string    :send_time
      t.boolean     :nb4
      t.references  :user
    end
  end

  def self.down
    drop_table :alarms
  end
end
