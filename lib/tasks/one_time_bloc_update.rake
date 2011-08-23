desc "This adds the nct value to each ct element"
task :one_time_bloc_update => :environment do
  Block.delete_all
  FasterCSV.foreach("db/map.csv") do |row|
    Block.create!(:cnn => row[0], :streetname=> row[1],:suff=>row[2],:botl =>row[3],:topl =>row[4],:botr =>row[5],:topr =>row[6],:tx =>row[7],:bx =>row[8],:nhood =>row[9])
  end
end