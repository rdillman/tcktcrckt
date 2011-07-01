class UserMailer < ActionMailer::Base
    default :from => "no-reply@tcktcrckt.com"
  
  def send_alert(alert)
    user= User.find(alert.user_id)
    @alarm_message = "Warning! Your location, "<<alert.location<<" will be swept at"<<alert.clean_time<<". - tcktcrckt"
    mail(:to => user.text_address,:subject => "The Ticket Police are Coming!")
  end
  
  def send_val_code(usr,code)
    @val_code = code
    mail(:to => usr.text_address,:subject => "Validation Code")
  end
  
end
