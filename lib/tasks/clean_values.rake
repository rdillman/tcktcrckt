desc "read the fucking file name"
task :clean_values => :environment do
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
