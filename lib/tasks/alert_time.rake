desc "read the fucking file name"
task :alert_time => :environment do
  now = Time.now.strftime(I18n.translate("time.formats.short"))
  alerts = Alarm.where("send_time=?",now)
  alerts.each do |x|
    UserMailer.send_alert(x).deliver
    x.destroy
  end
end