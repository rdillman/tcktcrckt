class MapzController < ApplicationController
  layout nil
  
  def timecnn
     @usr_qry = params[:q]
      if @usr_qry
        @results = Block.block_data(@usr_qry,nil)
        @recenter = 0
        respond_to do |format|  
          format.html    
          format.js
          format.xml {render :xml => @results}
          format.xml {render :xml => @recenter}
          
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
        and_regex = /((\d*)[a-zA-Z]+(\s)+)+([aA][nN][dD]|&+)(\s)+((\d*)[a-zA-Z]+(\s)*)+/
        between_regex =/((\d*)[a-zA-Z]+(\s)+)+[bB][eE][tT][wW][eE]+[nN](\s)+((\d*)[a-zA-Z]+(\s)+)+([aA][nN][dD]|&+)(\s)+((\d*)[a-zA-Z]+(\s)*)+/
        @results = nil
        @recenter = nil
        if between_regex === @usr_qry
          @results, @recenter = Block.block_from_between(@usr_qry)
        elsif and_regex === @usr_qry
          @results, @recenter = Block.block_from_intersection(@usr_qry)
        else
          @cnn, @side = Block.lookup_cnn(@usr_qry)
          if @side != -1
            @results = Block.block_data(@cnn[0].cnn,@side)
            @recenter = 1
          else
            @results = nil
            @recenter = nil
          end
        end
       #What does res mean?? Does uq mean user_query?
       
        respond_to do |format|      
          format.html {render :html => "#{Rails.root}/app/views/mapz/timecnn.html.erb"}
          format.js
          format.xml {render :xml => @results}
          format.xml {render :xml => @recenter}
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
