class Block < ActiveRecord::Base
  
  def self.ltp_from_cnn(cnn,radius)
    dest = Point.find_by_cnn(cnn)
    if dest
      Block.long_term_parking(dest.lat,dest.lng,radius)
    else
      "Block Not Found"
    end
  end
  
  def self.ltp_from_addr(addr,radius)
    dest = Block.lookup_cnn(addr)
    Block.ltp_from_cnn(dest[0][0].cnn,radius)
  end
  
  
  def self.long_term_parking(lat,lng,radius)
    
    cnns = Point.nearby_cnns(lat,lng,radius)
    start = Time.now
    winner = nil
    nts = Array.new
    cnns.each do |cnn|
      tmp = Block.find_by_cnn_and_cleaned(cnn,TRUE)
      if tmp
        holder = Array.new
        nt = tmp.next_ct_from_cnn
        if nt != "Oops We Don't Have a Cleaning Record for this Street"
          holder<<nt
          holder<<tmp.id
          nts<<holder
        end
      end
    end
    stop = Time.now
    nts.max
    print("Block.ltp time in seconds : "<<(stop-start).to_s<<"\n")
    return nts.max
  end


  def self.next_ct_from_cnn(cnn)
    return Clean.next_ct_from_cnn(cnn)
  end


  #This one is all switched up because the city lists the botl and topl of some addresses in the botr and topr fields
  #But there is as an easy fix - just run 
  def self.fucking_city_done_fucked_up(addr,street,suff,side)
    l_no_suff_sql = "streetname = ?  AND botl <= ? AND topl >= ?"
    r_no_suff_sql = "streetname = ?  AND botr <= ? AND topr >= ?"
    l_suff_sql = "streetname = ? AND suff = ? AND botl <= ? AND topl >= ?"
    r_suff_sql = "streetname = ? AND suff = ? AND botr <= ? AND topr >= ?"
    if side == 'L'
      if suff
        @bl = Block.where(r_suff_sql,street,suff,addr,addr)
      else
        @bl = Block.where(r_no_suff_sql,street,addr,addr)
      end
    else
      if suff
        @bl = Block.where(l_suff_sql,street,suff,addr,addr)
      else
        @bl = Block.where(l_no_suff_sql,street,addr,addr)
      end
    end 
    return @bl
  end

  def self.parse_query(uq)
    uq.upcase!
    str_parts = uq.split

    #deal with suffix
    suffix = Suffix.valid_suff?(str_parts.last)
    if suffix
      str_parts.pop
    end

    #format streetname
    strlen = str_parts.size
    streetname = str_parts.pop(strlen-1)
    streetname = streetname.join(" ")
    if !Street.valid_street?(streetname)
      streetname = nil # no streetname
    end

    #deal with addr
    num = nil
    if str_parts =~/[^0-9]+/
      num = -1 # Probably no number
    else
      num = str_parts[0].to_i
    end

    return num,streetname,suffix

  end

  def self.lookup_cnn(usr_qry)
    #possible sql search terms - right side of street no suffix, left side....
    l_no_suff_sql = "streetname = ?  AND botl <= ? AND topl >= ?"
    r_no_suff_sql = "streetname = ?  AND botr <= ? AND topr >= ?"
    l_suff_sql = "streetname = ? AND suff = ? AND botl <= ? AND topl >= ?"
    r_suff_sql = "streetname = ? AND suff = ? AND botr <= ? AND topr >= ?"

    @bl = nil
    addr,street,suff = Block.parse_query(usr_qry)

    #If the streetname is valid search the db using streetname, 
    #suffix and address as parameters
    if Block.valid_addr?(addr,street,suff)
      side = Block.get_side(addr)    
        if side == 'R'
          if suff
            @bl = Block.where(r_suff_sql,street,suff,addr,addr)
          else
            @bl = Block.where(r_no_suff_sql,street,addr,addr)
          end
        else
          if suff
            @bl = Block.where(l_suff_sql,street,suff,addr,addr)
          else
            @bl = Block.where(l_no_suff_sql,street,addr,addr)
          end
        end
        #If nothing went wrong return 
        if @bl != []
          return @bl,side

        #Maybe it was the city's fault?
        else
          @bl =  Block.fucking_city_done_fucked_up(addr,street,suff,side)

          #did it work>
          if @bl != []
             return @bl,side
          #Prob incorrect address
          else
            return "We don't have a record for that address for that street", -1
          end
        end
    else
      return "Invalid Address",-1
    end
  end


  
  def self.next_ct_from_addr(usr_qry)
    #@bl is a list of blocks 
    bl,side = Block.lookup_cnn(usr_qry)

    if@bl.size > 1
      return @bl,"Which of these Streets?"
    end

    #Go through all the cts for a given block and find the smallest
    if side != -1
      return Block.get_best_ct(bl[0].cnn)
    else
      return "Invalid Address - No Address or No Street"
    end
  end
  
  
  
  
  
  
  ##################################
####### HELPER AND WRAPPER METHODS ###########
  ##################################
  
  
  def self.get_best_ct(cnn)
    @cts = Clean.where("cnn = ? AND side =?", cnn, side)
    if @cts == [] #FUCK we don't have the records - maybe in the north beach or ingleside black hole?
      return "Oops We Don't Have a Cleaning Record for this Street"
    else
      nts = Array.new
      @cts.each {|x| nts << x.nct_to_times}
      b = nts.min
      return b
    end
  end
  
  
  
  def next_ct_from_cnn
    if self.cleaned
      return Clean.next_ct_from_cnn(self.cnn)
    else
      return nil
    end
  end

  def self.get_side(addr)
    if addr.even?
      return "R"
    else
      return "L"
    end
  end

  def self.valid_addr?(addr,street,suff)
    street && addr != -1
  end
end
