class AlertController < ApplicationController
  def show
  end

  def create
    @usr_qry = params[:q]
    @results = Block.next_ct_from_addr(@usr_qry)
    
  
  #
  #  
  #Problem Cases ############################################################## 
  # 
    if @results == "Invalid Address - No Address or No Street"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/no_street.html.erb"}
          format.xml  { render :xml => @results }
          format.xml {render :xml => @usr_qry}
      end
    elsif @results == "We don't have a record for that address for that street"
       respond_to do |format|
         format.html { render :file => "#{Rails.root}/app/views/alert/no_street.html.erb"}
           format.xml  { render :xml => @results }
           format.xml {render :xml => @usr_qry}
       end
    elsif @results == "Invalid Address"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/no_street.html.erb"}
          format.xml  { render :xml => @results }
          format.xml {render :xml => @usr_qry}
      end
    elsif @results[1] == "Which of these Streets?"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/multiple.html.erb"}
          format.xml  {render :xml => @results }
          format.xml {render :xml => @usr_qry}
      end
    elsif @results == "Oops We Don't Have a Cleaning Record for this Street"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/no_record.html.erb"}
          format.xml {render :xml => @usr_qry}
      end
        
  #
  #End Problem Cases #########################################################    
  #    
  #    
    else
      
  #
  # Ideal case ###################################################################
  #
      send = @results[0] - 1.hour
      @a = Alarm.create!(:location => @usr_qry, :clean_time => @results[0].strftime("%B %e %y %H:%M"), :send_time => send.strftime("%B %e %y %H:%M"), :nb4 => false)
      if @a
        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @a }
        end
      end
    end
    
  end

  def kill
  end

end
