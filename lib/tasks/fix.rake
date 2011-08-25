desc "fix"
task :fix => :environment do
  x = Ct.find(412)
  puts("ct : "+x.id.to_s)  
  x.update_attribute(:nct,x.next_time)
  cleans = Clean.where("ct_id =?",x.id)
  cleans.each do |c|
    c.update_attribute(:nct,x.nct)
    puts("clean : "+c.id.to_s)
  end
end
