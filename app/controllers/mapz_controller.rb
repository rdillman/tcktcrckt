class MapzController < ApplicationController
  layout nil
  
  def timecnn
     @usr_qry = params[:q]
      if @usr_qry
        @st,@sf,@br,@tr,@rside,@rnct,@right_times,@rhol,@bl,@tl,@lside,@lnct,@left_times,@lhol = Block.get_map_req_from_cnn(@usr_qry)
        respond_to do |format|  
          format.html    
          format.js
          format.xml {render :xml => @st}
          format.xml {render :xml => @sf}
          format.xml {render :xml => @br}
          format.xml {render :xml => @tr}
          format.xml {render :xml => @rside}
          format.xml {render :xml => @rnct}
          format.xml {render :xml => @right_times}
          format.xml {render :xml => @rhol}
          format.xml {render :xml => @bl}
          format.xml {render :xml => @tl}
          format.xml {render :xml => @lside}
          format.xml {render :xml => @lnct}
          format.xml {render :xml => @left_times}
          format.xml {render :xml => @lhol}
        end
      else
        @message = "Please Enter Something"
        respond_to do |format|      
          format.html
          format.js
          format.xml {render :xml => @message}
        end
      end
  end

  def timequery
     @usr_qry = params[:q]
      @user = current_user
      if @usr_qry
        standard_regex = /\d+(\s)*((\d*)[a-zA-Z]*(\s)*)+/
        and_regex = /((\d*)[a-zA-Z]+(\s)+)+([aA][nN][[dD]|&+)(\s)+((\d*)[a-zA-Z]+(\s)*)+/
        between_regex =/((\d*)[a-zA-Z]+(\s)+)+[bB][eE][tT][wW][eE]+[nN](\s)+((\d*)[a-zA-Z]+(\s)+)+([aA][nN][[dD]|&+)(\s)+((\d*)[a-zA-Z]+(\s)*)+/
        
        if between_regex === @usr_qry
          @results = Block.block_from_between(@usr_qry)
        elsif and_regex === @usr_qry
          @results = Block.block_from_intersection(@usr_qry)
        else
          @results = Block.next_ct_from_addr(@usr_qry)
        end
        debugger
       #What does res mean?? Does uq mean user_query?


        respond_to do |format|      
          format.html
          format.js
          format.xml {render :xml => @results}
        end
      else
        @message = "Please Enter Something"
        respond_to do |format|      
          format.html
          format.js
          format.xml {render :xml => @message}
          format.xml {render :xml => @address}
        end
      end
  end
  
  def home
  end

end
