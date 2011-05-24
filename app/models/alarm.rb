class Alarm < ActiveRecord::Base
  attr_accessible    :location, :clean_time, :send_time, :nb4, :user, :cnn
end
