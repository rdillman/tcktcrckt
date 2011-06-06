class UserMailer < ActionMailer::Base
  default :from => "tcktcrckt@tcktcrckt.com"
    
  def send_alert(alert)
    @user= User.find(alert.user_id)
    @alarm_message = "Warning! Your location, "<<alert.location<<" will be swept at"<<alert.clean_time<<"."
    mail(:to =>"<#{@user.text_address}>", :subject => "TicketCricket Alert!")
  end
end
