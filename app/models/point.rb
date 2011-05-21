class Point < ActiveRecord::Base
  def self.unique_cnns(cnns)
    unique_cnns = Array.new
    cnns.each{|x|unique_cnns << x.cnn}
    unique_cnns.uniq!
  end
end
