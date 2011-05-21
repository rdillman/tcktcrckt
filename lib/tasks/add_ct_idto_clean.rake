desc "read the fucking file name"
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
  
end
