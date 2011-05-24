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
    @results = Block.next_ct_from_addr(@usr_qry)
    
  
  #
  #  
  #Problem Cases ############################################################## 
  # 
    if @results == "Invalid Address - No Address or No Street"
      @message = @results
      @message <<" "<< @usr_qry
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
        format.xml  {render :xml => @message}
      end
    elsif @results == "We don't have a record for that address for that street"
      @message = @results
      @message<<" "<<usr_qry
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
        format.xml  {render :xml => @message}
       end
    elsif @results == "Invalid Address"
      @message = @results
      @message<<" "<<@usr_qry
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
        format.xml  {render :xml => @message}
      end
    elsif @results[1] == "Which of these Streets?"
      @message = @results
      @message<<" "<<@usr_qry
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
        format.xml  {render :xml => @message}
      end
    elsif @results == "Oops We Don't Have a Cleaning Record for this Street"
      @message = @results
      @message<<" "<<@usr_qry
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
        format.xml  {render :xml => @message}
      end
    elsif alert_exists?(@results[1],@user)
      @message = exists_message
      @alerts = Alarm.all
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
        format.xml  { render :xml => @message}
        format.xml  { render :xml => @alerts}
      end
      
  #
  #End Problem Cases #########################################################    
  #    
  #    
    else
      
  #
  # Ideal case ###################################################################
  #
      send = @results[0][0] - 1.hour
      @a = Alarm.create!(:location => @usr_qry, :clean_time => @results[0][0].strftime("%B %e %y %H:%M"), :send_time => send.strftime("%B %e %y %H:%M"), :cnn => @results[1], :nb4 => false, :user_id => @user.id)
      if @a
        @message = create_message(@a)
        @alerts = Alarm.all
        respond_to do |format|
            format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
            format.xml  { render :xml => @alerts }
            format.xml  { render :xml => @message }
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
  
  def exists_message
    "An alert for this block already exists"
  end

end
