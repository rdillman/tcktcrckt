class UserMailer < ActionMailer::Base
    default :from => "no-reply@tcktcrckt.com"
  
  def send_alert(alert)
    @user= User.find(alert.user_id)
    user = @user
    @alarm_message = "Warning! Your location, "<<alert.location<<" will be swept at"<<alert.clean_time<<". - tcktcrckt"
    mail(:to => "2565414750@txt.att.net",:subject => "TicketCricket Alert!")
  end
  
  
end
