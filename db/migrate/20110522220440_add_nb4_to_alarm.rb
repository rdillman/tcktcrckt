class AddNb4ToAlarm < ActiveRecord::Migration
  def self.up
    add_column :alarms, :nb4, :boolean
  end

  def self.down
    remove_column :alarms, :nb4
  end
end
