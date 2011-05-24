desc "Determine the Ct and BLock for each Cleaning record"
task :add_ct_idto_clean => :environment do
  
  Clean.find_each(:batch_size => 1000) do |c|
    a = Ct.where("wday = ? AND start = ? AND stop =? AND boolyuns =?",c.wday,c.start,c.stop,c.boolyuns)
    c.update_attribute(:ct_id,a[0].id)
    a = Block.find_by_cnn(c.cnn)
    if a
      c.update_attribute(:block_id,a.id)
      print(c.block_id)
    end
  end
  
  Ct.all.each do |c|
    c.update_attribute(:nct,c.next_time.join('|'))
  end
  
  Clean.all.each do |cl|
    cl.update_attribute(:nct,Ct.find(cl.ct_id).nct)
  end

  #Block.all.each{|x| x.update_attribute(:cleaned, false)}
  a = Clean.all
  cnns = Point.unique_cnns(a)
  cnns.each do |x| 
    tmp = Block.find_by_cnn(x)
    if tmp
      tmp.update_attribute(:cleaned, true)
    end
  end

  
  
end
