class UserMailer < ActionMailer::Base
  default :from => "tcktcrckt@tcktcrckt.com"
    
  def send_alert(alert)
    if alert
      @user= User.find(alert.user_id)
      @alarm_message = "Warning! Your location, "<<alert.location<<" will be swept at"<<alert.clean_time<<". - tcktcrckt"
      mail(:to =>"<#{@user.text_address}>", :subject => "TicketCricket Alert!")
    else
      return nil
    end
  end
end
