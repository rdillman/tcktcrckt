class AlertController < ApplicationController
  before_filter :authenticate_user!
  before_filter :validated?
  
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
      @message = "you have no alerts"
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
    if Alarm.exists?(@alarm)
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
      @message = I18n.translate('alert_controller.edit.success')
      @box = "success"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb" }
        format.xml  { render :xml => @alerts }
        format.xml  { render :xml => @message }
        format.xml  { render :xml => @box }
        end
    else
      @message = I18n.translate('alert_controller.edit.warn')
      @box = "warn"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb" }
        format.xml  { render :xml => @alerts }
        format.xml  { render :xml => @message }
        format.xml  { render :xml => @box }
      end
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
    @message = I18n.translate('alert_controller.update_phone.success')
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
  
    elsif alert_exists?(res[1],@user,@st)
       do_alert_exists
    elsif res == "empty"
        do_empty
  #
  #End Problem Cases #########################################################    
  #    
  #    
     else 
  #
  # Ideal case ###################################################################
  #
  
  # Is there a User? #############################################################
  
  if !@user && !no_alarm?(@st[0])
    redirect_to "/users/sign_in"
  # elsif !@user.validated?
  #     @box = "info"
  #     @message "Before "
  #     respond_to do |format|
  #       format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
  #       format.xml  {render :xml => @message}
  #       format.xml  {render :xml => @box}
  #     end
    else
    #Construct Alarm
    @a = nil
        if (night_before?(@st[0])) #Night Before Case
          @a = make_nb4_alarm(@usr_qry,@results,@user)
        elsif (no_alarm?(@st[0]))
          @message = I18n.translate('alert_controller.create.construct_alarm.next_clean')<<I18n.localize(@results[0][0])
          send = @results[0][0] - 1.hour
          @box = "info"
          @alerts = Alarm.where("user_id = ?",current_user.id)
          respond_to do |format|
            format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
            format.xml  {render :xml => @message}
            format.xml  {render :xml => @box}
            format.xml  { render :xml => @alerts }
          end
        else  
          @a = make_regular_alarm(@usr_qry,@results,@user)
        end
      
      
      
        #If it worked --- 
        if @a
          @user.update_rec(uq)
          if !@user.phone_number or !@user.carrier
            @message = I18n.translate('alert_controller.create.construct_alarm.warn')
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
  end
  

  

  def kill
    kill_id = params[:q]
    if Alarm.exists?(kill_id)
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
            format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
          end
        end
    else
      @message = I18n.translate('alert_controller.create.kill.delete')
      @alerts = Alarm.where("user_id = ?",current_user.id)
      @box = "success"
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
        format.xml  { render :xml => @alerts }
        format.xml  { render :xml => @message }
        format.xml  {render :xml => @box}
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
     @a = Alarm.create!(:location => uq, :clean_time => I18n.localize(@results[0][0]), :send_time => I18n.localize(nb4_time), :cnn => res[1], :nb4 => true, :user_id => usr.id)

  end
    
    def make_regular_alarm(uq,res,usr)
        send = res[0][0] - 1.hour
        @a = Alarm.create!(:location => uq, :clean_time => I18n.localize(@results[0][0]), :send_time => I18n.localize(send), :cnn => res[1], :nb4 => false, :user_id => usr.id)
    end
  
  def night_before?(alarm_type)
    alarm_type == 78
  end
  
  def no_alarm?(alarm_type)
    alarm_type == 68
  end
  
  
    
  
  def create_message(alert)
    message = I18n.translate('alert_controller.create_message.alert_created')
    message << alert.location
    message << I18n.translate('alert_controller.create_message.begins')
    message << alert.clean_time
  end
  
  def kill_message(alert)
    message = I18n.translate('alert_controller.kill_message.alert_for')
    message << alert.location
    message << I18n.translate('alert_controller.kill_message.deleted')
  end
     
  def alert_exists?(cnn, user, st)
    if !user
      return false
    end
    if st == "Don't Create an Alarm"
      return false
    end
    if Alarm.where("cnn = ? AND user_id = ?", cnn, user.id) != []
      return true
    else
      return false
    end
  end
  
  def do_alert_exists
    @message = I18n.translate('alert_controller.do_alert_exists.message')
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
    @message = I18n.translate('alert_controller.create.res.invalid_address')
    @message<<" "<<uq
    @box = "error"
    @alerts = Alarm.where("user_id = ?",current_user.id)
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      
    end
  end
  
  def do_no_entry(uq)
    @alerts = Alarm.where("user_id = ?",current_user.id)
    @message = @results
    @message<<" "<<uq
    @box = "warn"
    
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      
      
    end
  end
  
  def do_multiple(res,uq)
    @alerts = Alarm.where("user_id = ?",current_user.id)
    @message = I18n.translate('alert_controller.do_multiple.message')
    @box = "info"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      
    end
  end
  
  def do_empty
    @alerts = Alarm.where("user_id = ?",current_user.id)
    @message = I18n.translate('alert_controller.do_empty.message')
    @box = "error"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/alert/show.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      
    end
  end

        
  
  def validated?

    @user = current_user
    if @user.phone_number != @user.valphone
      redirect_to :controller => "validator", :action => "enter"
    end
  end
end
