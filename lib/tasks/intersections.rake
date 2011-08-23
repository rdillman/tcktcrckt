desc "Crack Cocaine!"
task :intersections => :environment do
  block_counter = Block.first.id
  FasterCSV.foreach("db/map.csv") do |row|
    a = Block.find(block_counter)
    a.update_attribute(:int1,row[0])
    a.update_attribute(:int2,row[2])
    a.save!
    if block_counter%1000 == 0
      put(a)
    end
  end
  end