start = Time.now 

Point.delete_all
FasterCSV.foreach("db/point.csv") do |row|
  Point.create!(:cnn => row[0],:lat => row[1],:lng => row[2])
end
last = Time.now
time_str = (last-start).to_s
puts("Point loaded - time (in seconds) : "<<time_str)

  
Ct.delete_all
FasterCSV.foreach("db/ct.csv", :col_sep => ' ') do |row|
  Ct.create!(:wday => row[0], :start => row[1], :stop => row[2], :boolyuns => row[3])
end
time_str = (Time.now-last).to_s
last = Time.now
puts("Ct loaded  - time (in seconds) : "<<time_str)

Block.delete_all
FasterCSV.foreach("db/block.csv") do |row|
  Block.create!(:cnn => row[0], :streetname=> row[1],:suff=>row[2],:botl =>row[3],:topl =>row[4],:botr =>row[5],:topr =>row[6],:txcnn =>row[7],:bxcnn =>row[8],:nhood =>row[9])
end
time_str = (Time.now-last).to_s
last = Time.now
puts("Block loaded - time (in seconds) : "<<time_str)

Street.delete_all
FasterCSV.foreach("db/street.csv") do |row|
  Street.create!(:streetname => row[0])
end
time_str = (Time.now-last).to_s
last = Time.now
puts("Street loaded - time (in seconds) : "<<time_str)

Suffix.delete_all
FasterCSV.foreach("db/suffix.csv") do |row|
  Suffix.create!(:suff => row[0])
end
time_str = (Time.now-last).to_s
last = Time.now
puts("Suffix loaded - time (in seconds) : "<<time_str)

Nhood.delete_all
FasterCSV.foreach("db/nhood.csv") do |row|
  Nhood.create!(:nhood => row[0])
end
time_str = (Time.now-last).to_s
last = Time.now
puts("Nhood loaded - time (in seconds) : "<<time_str)

Xion.delete_all
FasterCSV.foreach("db/xion.csv") do |row|
  Xion.create!(:xcnn=> row[0],:streetname=>row[1])
end
time_str = (Time.now-last).to_s
last = Time.now
puts("Xion loaded - time (in seconds) : "<<time_str)

Clean.delete_all
FasterCSV.foreach("db/clean_lookup.csv") do |row|
  bool = row[1].split
  Clean.create!(:cnn=>row[0],:wday=>bool[0],:start=>bool[1],:stop=>bool[2],:boolyuns => bool[3],:dir =>row[2], :side =>row[3])
end  

time_str = (Time.now-last).to_s
last = Time.now
puts("Clean loaded - time (in seconds) : "<<time_str)

stop = Time.now
time_str = (stop-start).to_s
puts("Time (in seconds) : "<<time_str)