desc "Run every hour, this updates "
task :hourly_update => :environment do
  now = Time.now
  wday = now.strftime("%a")
  start = now.strftime("%H:00")
  cts = Ct.where("wday = ? AND start =?",wday,start)
  cts.each do |x|
    x.update_attribute(:nct,x.next_time.join('|'))
    cleans = Clean.where("ct_id =?",x.ct_id)
    cleans.each do |c|
      c.update_attribute(:nct,x.nct)
    end
  end
end
      
  