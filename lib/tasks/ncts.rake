desc "This adds the nct value to each ct element"
task :ncts => :environment do
  Ct.all.each do |c|
    c.update_attribute(:nct,c.next_time.join('|'))
    print(c.id)
  end
  Clean.all.each do |cl|
    cl.update_attribute(:nct,Ct.find(cl.ct_id).nct)
  end
  
#  b = Block.where("cleaned =? ", true)
#  b.each do |block|
#    cleans = Clean.where("cnn =? AND side =?",block.cnn,"R")
#    nts = Array.new
#    if cleans
#      nts = Array.new
#      cleans.each {|x| nts << x.nct_to_times}
#      fuck = nts.min
#     if fuck
#        best = fuck.join('|')
#        block.update_attribute(:nct, best)
#      end
#    end
#    cleans = Clean.where("cnn =? AND side =?",block.cnn,"L")
#    nts = Array.new
#    if cleans
#     nts = Array.new
#      cleans.each {|x| nts << x.nct_to_times}
#      fuck = nts.min
#      if fuck
#        best = fuck.join('|')
#        block.update_attribute(:nct, block.nct<<"|"<<best)
#      end
#    end
#   
#  end
  
end
