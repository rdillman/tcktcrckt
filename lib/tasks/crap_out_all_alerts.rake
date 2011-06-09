desc "read the fucking file name"
task :crap_out_all_alerts => :environment do
    now = Time.now.strftime("%H:00 %B %e, %Y")
    Alarm.all.each do |x|
      UserMailer.send_alert(x).deliver
      x.destroy
    end
  end
end