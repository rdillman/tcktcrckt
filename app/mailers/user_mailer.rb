class UserMailer < ActionMailer::Base
  default :from => "tcktcrckt@tcktcrckt.com"
    
  def send_alert(alert)
    if alert && user.phone_number && user.carrier
      @user= User.find(alert.user_id)
      user = @user
      @alarm_message = "Warning! Your location, "<<alert.location<<" will be swept at"<<alert.clean_time<<". - tcktcrckt"
      mail(:to => "<#{user.text_address}>", :subject => "TicketCricket Alert!")
    else
      return nil
    end
  end

end
