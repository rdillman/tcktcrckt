class Street < ActiveRecord::Base
  def self.valid_street?(street)
    if Street.find_by_streetname(street)
      return true
    else
      return false
    end
  end
end
