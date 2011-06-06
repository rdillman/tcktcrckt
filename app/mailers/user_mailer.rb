class UserMailer < ActionMailer::Base
  default :from => "tcktcrckt@tcktcrckt.com"
  
  def fuck(user)
    @user = user
    debugger
    mail(:to => "<#{user.email}>", :subject => "Registered")
  end
end
