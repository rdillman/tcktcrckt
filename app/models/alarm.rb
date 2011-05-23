class Alarm < ActiveRecord::Base
  has_one :user
  has_one :ct
  
  def init_alarm(start_time, end_time, location)
    user = current_user
  end
  
  def make_message()
  end
    
end
