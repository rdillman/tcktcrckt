desc "read the fucking file name"
task :alert_time => :environment do
    now = Time.now.strftime("%H:00 %B %e, %Y")
    alerts = Alarm.where("send_time=?",now)
    alerts.each do |x|
      UserMailer.send_alert(x).deliver
      x.destroy
    end
  end
end