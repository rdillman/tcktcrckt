desc "fuck "
task :fuck => :environment do
  
  Clean.delete_all
  FasterCSV.foreach("db/clean_lookup.csv") do |row|
    bool = row[1].split
    Clean.create!(:cnn=>row[0],:wday=>bool[0],:start=>bool[1],:stop=>bool[2],:boolyuns => bool[3],:dir =>row[2], :side =>row[3])
  end
end
