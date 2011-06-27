desc "Determine the Ct and BLock for each Cleaning record"
task :test_email => :environment do
  if UserMailer.send_alert(Alarm.first).deliver
    print("success")
  else
    print("failure")
  end
end