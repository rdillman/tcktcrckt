class Suffix < ActiveRecord::Base
  def self.valid_suff?(str)
    suff_str_sql = "suff = ? OR alias = ?"
    s = Suffix.where(suff_str_sql,str,str)
    if s ==[]
      return nil
    else
      return s.first.suff
    end
  end
end
