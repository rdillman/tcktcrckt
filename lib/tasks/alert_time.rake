desc "read the fucking file name"
task :alert_time => :environment do
  now = Time.now.strftime("%B %e %Y at %H:%M")
  alerts = Alarm.where("send_time=?",now)
  alerts.each do |x|
    UserMailer.send_alert(x).deliver
    x.destroy
  end
end