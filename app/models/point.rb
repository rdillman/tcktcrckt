class Point < ActiveRecord::Base
  #acts_as_mappable
  
  def nearby_cnns(radius)
    start = Time.now
    Point.nearby_cnns(self.lat,self.lng,radius)
    stop = Time.now
    print("Point.nearby_cnns time in seconds : "<<(stop-start).to_s<<"\n")
  end
  
  def self.unique_cnns(cnns)
    unique_cnns = Array.new
    cnns.each{|x|unique_cnns << x.cnn}
    unique_cnns.uniq!
  end
  
  def self.nearby_cnns(lat,lng,radius)
    @nearby = Point.find(:all, :origin => [lat,lng], :within => radius)
    @cnns = Point.unique_cnns(@nearby)
  end
  
  def self.make_line_string(f,cnn)
    @cnns = Point.where("cnn = ?", cnn)
    points = Array.new
    @cnns.each{|x| points << f.point(x.lat,x.lng)}
    line = f.line_string(points)
  end
end
