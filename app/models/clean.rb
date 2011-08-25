class Clean < ActiveRecord::Base
  def nct_to_times
    nct_str = self.nct
    nct_str = nct_str.split('|')

    times = Array.new        
    times << Chronic.parse(nct_str[0].sub("Thu","Thursday"))
    times << Chronic.parse(nct_str[1].sub("Thu","Thursday"))
    return times
  end
  
  def self.next_ct_from_cnn(cnn)
    cts = Clean.where("cnn = ?",cnn)
    if cts == [] #FUCK we don't have the records - maybe in the north beach or ingleside black hole?
      return "Oops We Don't Have a Cleaning Record for this Street"
    else
      nts = Array.new
      cts.each {|x| nts << x.nct_to_times}
      b = nts.min
      return b
    end
  end
  
end
