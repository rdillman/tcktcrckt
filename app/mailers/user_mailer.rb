class UserMailer < ActionMailer::Base
  default :from => "tcktcrckt@tcktcrckt.com"
    
  def send_alert(alert)
    if !alert
      return nil
    end
    @user= User.find(alert.user_id)
    if !@user.phone_number or !@user.carrier
      return nil
    end
    @alarm_message = "Warning! Your location, "<<alert.location<<" will be swept at"<<alert.clean_time<<". - tcktcrckt"
    mail(:to => "<#{user.text_address}>", :from => "tcktcrckt@tcktcrckt.com",:subject => "TicketCricket Alert!")
  end
end
