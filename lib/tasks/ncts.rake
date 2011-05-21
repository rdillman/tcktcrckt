desc "This adds the nct value to each ct element"
task :ncts => :environment do
  Ct.all.each do |c|
    c.update_attribute(:nct,c.next_time.join('|'))
  end
end
