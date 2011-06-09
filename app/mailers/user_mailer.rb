class UserMailer < ActionMailer::Base
    default :from => "no-reply@tcktcrckt.com"
  
  def send_alert(alert)
    @user= User.find(alert.user_id)
    user = @user
    @alarm_message = "Warning! Your location, "<<alert.location<<" will be swept at"<<alert.clean_time<<". - tcktcrckt"
    mail(:to => @user.text_address,:subject => "TicketCricket Alert!")
  end
  
  
end
