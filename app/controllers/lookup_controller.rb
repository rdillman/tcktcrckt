class LookupController < ApplicationController
  layout nil
  layout 'application', :except => [:get_next_time, :delete_alert, :change_alert, :make_alert]
  
  def make_alert
    @user = current_user
    @usr_qry = params[:q]
    @results = Block.next_ct_from_addr(@usr_qry)
    nb4_time = @results[0][0]-1.day + (19 - @results[0][0].hour).hour
    send = @results[0][0] - 1.hour
    debugger
    @a = Alarm.create!(:location => @usr_qry, :clean_time => @results[0][0].strftime(I18n.translate('alert_controller.create.construct_alarm.construct_time')), :send_time => nb4_time.strftime(I18n.translate('alert_controller.create.construct_alarm.construct_time')), :cnn => @results[1], :nb4 => true, :user_id => @user.id)
    @user.update_rec(@usr_qry)
    respond_to do |format|      
      format.html
      format.xml {render :xml => @a}
    end
  end
  
  
  def get_next_time
    @usr_qry = params[:q]
    @user = current_user
    if @usr_qry
      @results = Block.next_ct_from_addr(@usr_qry)
    
     #What does res mean?? Does uq mean user_query?
      uq  = @usr_qry 
      @message = Array.new
      @address = @usr_qry
      if @results[0][0].class==Time
        @message = I18n.localize(@results[0][0])
        @image = "<<create alert link>>"
      else
        @message = @results 
      end
      respond_to do |format|      
        format.html
        format.js
        format.xml {render :xml => @message}
        format.xml {render :xml => @address}
        format.xml {render :xml => @image}
        
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
  
  def delete_alert
    kill_id = params[:q]
    if Alarm.exists?(kill_id)
      to_delete = Alarm.find(kill_id)
        if current_user.id == to_delete.user_id
          @message = "alert has been delete"
          if to_delete.destroy
            respond_to do |format|
              format.html 
              format.xml  { render :xml => @message }
            end
          end
        else
          respond_to do |format|
            format.html 
          end
        end
    else
      @message = "Alert Not Found"
      @alerts = Alarm.where("user_id = ?",current_user.id)
      @box = "success"
      respond_to do |format|
        format.html 
        format.xml  { render :xml => @message }
      end
    end
  end
  
  def change_alert
    @user = current_user
    @alarm = params[:q].to_i
    @message=''
    if Alarm.exists?(@alarm)
      
      alert = Alarm.find(@alarm)
      ct = Chronic.parse(alert.clean_time)
       if alert.nb4
        send = ct - 1.hour
        alert.update_attribute(:send_time, send.strftime("time.formats.short"))
        alert.update_attribute(:nb4, false)
        @message =I18n.translate('alert_controller.alert_messages.options.1_hour')
      else
        nb4_time = ct-1.day + (19 - ct.hour).hour
        alert.update_attribute(:send_time, nb4_time.strftime("time.formats.short"))
        alert.update_attribute(:nb4, true)
        @message =I18n.translate('alert_controller.alert_messages.options.night_before')
      end
      respond_to do |format|
        format.html 
        format.xml  { render :xml => @message }
        end
    else
      @message = I18n.translate('alert_controller.edit.warn')
      respond_to do |format|
        format.html 
        format.xml  { render :xml => @message }
      end
    end
  end
  
  def addr
    @usr_qry = params[:q]
    if @user = current_user
      @signedin = true
    else
      @signedin = false
    end
    

    
    if @usr_qry
      @results = Block.next_ct_from_addr(@usr_qry)
    
     #What does res mean?? Does uq mean user_query?
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
        
      elsif res == "empty"
          do_empty
      
      else 
        @message = I18n.localize(@results[0][0])
        @box = "info"
        if @user
          @alerts = Alarm.where("user_id =?",@user.id)
          @recs = []
          @recs << @user.rec1 <<@user.rec2<<@user.rec3
        end
        if params[:type] == "js"
             respond_to do |format|
                format.js        
              end
        else
          respond_to do |format|
            format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
            format.xml {render :xml => @signedin}
            format.xml  {render :xml => @message}
            format.xml  {render :xml => @box}
            format.xml  { render :xml => @alerts }
            format.xml {render :xml => @usr_qry}
            format.xml  { render :xml => @recs }
            
          end
        end
      end
      
    else
      if @user
        @alerts = Alarm.where("user_id =?",@user.id)
        @recs = []
        @recs << @user.rec1 <<@user.rec2<<@user.rec3
      end
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
        format.js
        format.xml  { render :xml => @alerts }
        format.xml  { render :xml => @recs }
        
      end
    end
      
  
  end
  
  def home
  end

  def map
  end
    
  private
   # Joseles - all the strings for il8n are in these functions
  
  def do_empty

    @alerts = Alarm.where("user_id = ?",current_user.id)
    @message = I18n.translate('alert_controller.do_empty.message')

    @user = current_user
    if @user
      @alerts = Alarm.where("user_id =?",@user.id)
      @recs = []
      # What does rec1, rec2, rec3 mean??? What does recs mean??
      @recs << @user.rec1 <<@user.rec2<<@user.rec3
    end
    @box = "error"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      format.xml  { render :xml => @recs }
      
      
    end
  end
  
  def do_invalid(res,uq)
    @message = I18n.translate('alert_controller.create.res.invalid')
    @user  = current_user
    @message<<" "<<uq
    @box = "error"
    if @user
      @alerts = Alarm.where("user_id =?",@user.id)
      @recs = []
      @recs << @user.rec1 <<@user.rec2<<@user.rec3
    end
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }     
      format.xml  { render :xml => @recs }
      
    end
  end
  
  def do_no_entry(uq)
    @message = I18n.translate('alert_controller.create.res.no_entry')
    @message<<" "<<uq
    @box = "warn"
    @user  = current_user
    if @user
      @alerts = Alarm.where("user_id =?",@user.id)
      @recs = []
      @recs << @user.rec1 <<@user.rec2<<@user.rec3
    end
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      format.xml  { render :xml => @recs }
      
      
    end
  end
  
  def do_multiple(res,uq)
    
    @message = I18n.translate('alert_controller.do_multiple.message')
    @box = "info"
    @user  = current_user
    if @user
      @alerts = Alarm.where("user_id =?",@user.id)
      @recs = []
      @recs << @user.rec1 <<@user.rec2<<@user.rec3
    end
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      format.xml  { render :xml => @recs }
      
    end
  end
  
  
  #Should this function be gone??
  def do_empty
    @message = I18n.translate('alert_controller.do_empty.message')
    @box = "error"
    @user  = current_user
    if @user
      @alerts = Alarm.where("user_id =?",@user.id)
      @recs = []
      @recs << @user.rec1 <<@user.rec2<<@user.rec3
    end
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      format.xml  { render :xml => @recs }
    end
  end
  

  
end
