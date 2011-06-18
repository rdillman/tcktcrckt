desc "Determine the Ct and BLock for each Cleaning record"
task :update_all_cleantimes => :environment do

  Ct.all.each do |x|
    x.update_attribute(:nct,x.next_time.join('|'))
    cleans = Clean.where("ct_id =?",x.id)
    cleans.each do |c|
      c.update_attribute(:nct,x.nct)
    end
  end
end