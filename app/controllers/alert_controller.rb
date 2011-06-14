class AlertController < ApplicationController
  
  def show
    @user = current_user
    @alerts = Alarm.where("user_id=?",@user.id)
    respond_to do |format|
      format.html
      format.xml {render :xml => @alerts}
    end
  end
  
  def beef
    user = current_user
    @alerts = Alarm.where("user_id=?",user.id)
    if @alerts != [] && UserMailer.send_alert(@alerts.first).deliver
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
        format.xml {render :xml => @alerts}
      end
    else
      @message = "you ain't got no alertz"
      @box = "error"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb" }
        format.xml  { render :xml => @alerts }
        format.xml  { render :xml => @message }
        format.xml  { render :xml => @box }
      end
    end
  end 
  
  def edit
    user = current_user
    @alerts = Alarm.where("user_id=?",user.id)
    @alarm = params[:alarm]
    alert = Alarm.find(@alarm)
    ct = Chronic.parse(alert.clean_time)
    if alert.nb4
      send = ct - 1.hour
      alert.update_attribute(:send_time, send.strftime("%B %e %Y at %H:%M"))
      alert.update_attribute(:nb4, false)
    else
      nb4_time = ct-1.day + (19 - ct.hour).hour
      alert.update_attribute(:send_time, nb4_time.strftime("%B %e %Y at %H:%M"))
      alert.update_attribute(:nb4, true)
    end
    @message = "Your Alert has been changed!"
    @box = "success"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb" }
      format.xml  { render :xml => @alerts }
      format.xml  { render :xml => @message }
      format.xml  { render :xml => @box }
      end
  end
  
  def update_phone
    @num = params[:num]
    @car = params[:car]
    user = current_user
    user.update_attribute(:phone_number, @num)
    user.update_attribute(:carrier, @car)
    user.save!
    @alerts = Alarm.where("user_id=?",@user.id)
    @message = "Your phone number had been updated "
    @box = "success"
    @message << user.phone_number.to_s
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
      format.xml {render :xml => @alerts}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      
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
  @a = nil
      if (night_before?(@st[0])) #Night Before Case
        
      @a = make_nb4_alarm(@usr_qry,@results,@user)
        # nb4_time = @results[0][0]-1.day + (19 - @results[0][0].hour).hour
        #       send = @results[0][0] - 1.hour
        #       @a = Alarm.create!(:location => @usr_qry, :clean_time => @results[0][0].strftime("%H:%M %B %e, %Y"), :send_time => nb4_time.strftime("%H:%M %B %e, %Y"), :cnn => @results[1], :nb4 => true, :user_id => @user.id)
      elsif (no_alarm?(@st[0]))
        @message = 'The next cleantime for that street begins at '<<@results[0][0].strftime("%A %B %e at %I:%M%p.")
        send = @results[0][0] - 1.hour
        @box = "info"
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
          format.xml  {render :xml => @message}
          format.xml  {render :xml => @box}
        end
      else  
        @a = make_regular_alarm(@usr_qry,@results,@user)
        # send = @results[0][0] - 1.hour
        #         @a = Alarm.create!(:location => @usr_qry, :clean_time => @results[0][0].strftime("%B %e %y %H:%M"), :send_time => send.strftime("%B %e %y %H:%M"), :cnn => @results[1], :nb4 => false, :user_id => @user.id)
      end
      
      
      
      #If it worked --- 
      if @a
        if !@user.phone_number or !@user.carrier
          @message = "Almost There! In order to send you alarms we need to know phone number and carrier"
          @box = "warn"
          respond_to do |format|
              format.html { render :file => "#{Rails.root}/app/views/alert/no_phone.html.erb"}
              format.xml  { render :xml => @message }
              format.xml  {render :xml => @box}   
          end       
        else
          @message = create_message(@a)
          @alerts = Alarm.where("user_id = ?",@user.id)
          @box = "success"
          respond_to do |format|
              format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
              format.xml  { render :xml => @alerts }
              format.xml  { render :xml => @message }
              format.xml  {render :xml => @box}
          end
        end   
      end
    end  
  end
  

  

  def kill
    kill_id = params[:q]
    to_delete = Alarm.find(kill_id)
    if current_user.id == to_delete.user_id
      @message = kill_message(to_delete)
      if to_delete.destroy
        @alerts = Alarm.where("user_id = ?",current_user.id)
        @box = "success"
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
          format.xml  { render :xml => @alerts }
          format.xml  { render :xml => @message }
          format.xml  {render :xml => @box}
        end
      end
    else
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      end
    end
  end

  def change_time
    change_id = params[:q]
    
  end


  private
  
  def make_nb4_alarm(uq, res, usr)
     nb4_time = res[0][0]-1.day + (19 - res[0][0].hour).hour
     send = res[0][0] - 1.hour
     @a = Alarm.create!(:location => uq, :clean_time => res[0][0].strftime("%B %e %Y at %H:%M"), :send_time => nb4_time.strftime("%B %e %Y at %H:%M"), :cnn => res[1], :nb4 => true, :user_id => usr.id)
  end
    
    def make_regular_alarm(uq,res,usr)
        send = res[0][0] - 1.hour
        @a = Alarm.create!(:location => uq, :clean_time => res[0][0].strftime("%B %e %Y at %H:%M"), :send_time => send.strftime("%B %e %Y at %H:%M"), :cnn => res[1], :nb4 => false, :user_id => usr.id)
    end
  
  def night_before?(alarm_type)
    alarm_type == 78
  end
  
  def no_alarm?(alarm_type)
    alarm_type == 68
  end
  
  
    
  
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
    @box ="warn"
    @alerts = Alarm.where("user_id = ?",current_user.id)
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
      format.xml  { render :xml => @message}
      format.xml  { render :xml => @alerts}
      format.xml  { render :xml => @box}
    end
  end

  
  def do_invalid(res,uq)
    @message = res
    @message<<" "<<uq
    @box = "error"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
    end
  end
  
  def do_no_entry(uq)
    @message = @results
    @message<<" "<<uq
    @box = "warn"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      
    end
  end
  
  def do_multiple(res,uq)
    @message = res
    @message<<" "<<uq
    @box = "info"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
    end
  end
  

        
  def exists_message
    "An alert for this block already exists"
  end

end
