desc "Crack Cocaine!"
task :intersections => :environment do
  block_counter = Block.first.id
  FasterCSV.foreach("db/map.csv") do |row|
    a = Block.find(block_counter)
    a.update_attribute(:tint,row[7])
    a.update_attribute(:bint,row[8])
    a.save!
    if block_counter%1000 == 0
      put(a)
    end
  end
  end