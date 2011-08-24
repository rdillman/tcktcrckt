desc "Reset the blocks"
task :one_time_bloc_update => :environment do
  puts("This test resets the Block db. It consists of two parts: the block reset and the :cleaned attribute update")
  puts("In total this test takes about 10 minutes to complete")
  start = Time.now 
  puts("Starting block reset")
  Block.delete_all
  FasterCSV.foreach("db/map.csv") do |row|
    Block.create!(:cnn => row[0], :streetname=> row[1],:suff=>row[2],:botl =>row[3],:topl =>row[4],:botr =>row[5],:topr =>row[6],:int1 =>row[7],:int2 =>row[8],:cleaned => false,:nhood =>row[9])
  end
  last = Time.now
  
  time_str = (last-start).to_s
  puts("Block reset completed - time (in seconds) : "<<time_str)  
  
  start = Time.now
  puts("Starting to add :cleaned variables")
  
  a = Clean.all
  cnns = Point.unique_cnns(a)
  cnns.each do |x| 
    tmp = Block.find_by_cnn(x)
    if tmp
      tmp.update_attribute(:cleaned, true)
    end
  end
  last = Time.now
  time_str = (last-start).to_s
  
  puts("Addition of :cleaned variables complete - time (in seconds) :"<<time_str)
  
end