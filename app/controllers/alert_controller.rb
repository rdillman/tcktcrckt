class AlertController < ApplicationController
  
  def show
    @alerts = Alarm.all
    respond_to do |format|
      format.html
      format.xml {render :xml => @alerts}
    end
  end

  def create
    
    @user = current_user
    @usr_qry = params[:q]
    @st = params[:st]
    @results = Block.next_ct_from_addr(@usr_qry)
    

  #
  #  
  #Problem Cases ############################################################## 
  # 
    res = @results
    uq  = @usr_qry 
    if res == "Invalid Address - No Address or No Street"
      do_invalid(res,uq)

    elsif res == "We don't have a record for that address for that street"
      do_invalid(res,uq)
  
    elsif res == "Invalid Address"
      do_invalid(res,uq)

    elsif res[1] == "Which of these Streets?"
      do_multiple(res,uq)

    elsif res == "Oops We Don't Have a Cleaning Record for this Street"
      do_no_entry(uq)
  
    elsif alert_exists?(res[1],@user)
       do_alert_exists
        
  #
  #End Problem Cases #########################################################    
  #    
  #    
     else 
  #
  # Ideal case ###################################################################
  #
  
  
  #Construct Alarm
  
      if (@st[0] == 78) #Night Before Case
        nb4_time = @results[0][0]-1.day + (19 - @results[0][0].hour).hour
        send = @results[0][0] - 1.hour
        @a = Alarm.create!(:location => @usr_qry, :clean_time => nb4_time.strftime("%B %e %y %H:%M"), :send_time => send.strftime("%B %e %y %H:%M"), :cnn => @results[1], :nb4 => false, :user_id => @user.id)
      
      elsif (@st[0] == 66)
        nb4_time = @results[0][0]-1.day + (19 - @results[0][0].hour).hour
        send = @results[0][0] - 1.hour
        @a = Alarm.create!(:location => @usr_qry, :clean_time => nb4_time.strftime("%B %e %y %H:%M"), :send_time => send.strftime("%B %e %y %H:%M"), :cnn => @results[1], :nb4 => true, :user_id => @user.id)
      
      elsif (@st[0] == 68)
        @message = @results[0][0]
        send = @results[0][0] - 1.hour
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
          format.xml  {render :xml => @message}
        end
      else  
        send = @results[0][0] - 1.hour
        @a = Alarm.create!(:location => @usr_qry, :clean_time => @results[0][0].strftime("%B %e %y %H:%M"), :send_time => send.strftime("%B %e %y %H:%M"), :cnn => @results[1], :nb4 => false, :user_id => @user.id)
      end
      
      
      
      #If it worked --- 
      if @a
        if !@user.phone_number or !@user.carrier
          respond_to do |format|
              format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
        end
        else
          @message = create_message(@a)
          @alerts = Alarm.where("user_id = ?",@user.id)
          respond_to do |format|
              format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
              format.xml  { render :xml => @alerts }
              format.xml  { render :xml => @message }
          end
        end   
      end
    end  
  end
  

  

  def kill
    kill_id = params[:q]
    to_delete = Alarm.find(kill_id)
    @message = kill_message(to_delete)
    if to_delete.destroy
      @alerts = Alarm.all
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
        format.xml  { render :xml => @alerts }
        format.xml  { render :xml => @message }
      end
    end
  end

  def change_time
    change_id = params[:q]
    
  end


  private
  
  def create_message(alert)
    message = "A alert has been created for the streetcleaning of "
    message << alert.location
    message << " which begins at "
    message << alert.clean_time
  end
  
  def kill_message(alert)
    message = "Streetcleaning alert for "
    message << alert.location
    message << "has been deleted."
  end
     
  def alert_exists?(cnn, user)
    if Alarm.where("cnn = ? AND user_id = ?", cnn, user.id) != []
      return true
    else
      return false
    end
  end
  
  def do_alert_exists
    @message = exists_message
    @alerts = Alarm.where("user_id = ?",current_user.id)
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
      format.xml  { render :xml => @message}
      format.xml  { render :xml => @alerts}
    end
  end

  
  def do_invalid(res,uq)
    @message = res
    @message<<" "<<uq
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
    end
  end
  
  def do_no_entry(uq)
    @message = @results
    @message<<" "<<uq
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
    end
  end
  
  def do_multiple(res,uq)
    @message = res
    @message<<" "<<uq
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
    end
  end
  

        
  def exists_message
    "An alert for this block already exists"
  end

end
