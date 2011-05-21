desc "read the fucking file name"
task :clean_values => :environment do
  a = Point.all
  cnns = Point.unique_cnns(a)
  cnns.each{|x| Block.find_by_cnn(x).update_attribute(:cleaned, true)}
end
