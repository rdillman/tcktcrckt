desc "This save the user, alerts, location,alarms and alarms tables. "
task :fill_cts => :environment do
  
  Ct.delete_all
  FasterCSV.foreach("db/ct.csv", :col_sep => ' ') do |row|
    Ct.create!(:wday => row[0], :start => row[1], :stop => row[2], :boolyuns => row[3])
  end
end