class LookupController < ApplicationController
  
  
  def addr
    @usr_qry = params[:q]
    
    if @usr_qry
      @results = Block.next_ct_from_addr(@usr_qry)
    
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
        @message = 'Next Streetclean:'<<@results[0][0].strftime("%A %B %e at %I:%M%p.")
        @box = "info"
        respond_to do |format|
          format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
          format.xml  {render :xml => @message}
          format.xml  {render :xml => @box}
        end
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
    @message = i18n.translate('alert_controller.do_empty.message')
    @box = "error"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      format.xml  { render :xml => @alerts }
      
    end
  end
  
  def do_invalid(res,uq)
    @message = i18n.translate('alert_controller.create.res.invalid')
    @message<<" "<<uq
    @box = "error"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
    end
  end
  
  def do_no_entry(uq)
    @message = i18n.translate('alert_controller.create.res.no_entry')
    @message<<" "<<uq
    @box = "warn"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
      
    end
  end
  
  def do_multiple(res,uq)
    
    @message = i18n.translate('alert_controller.do_multiple.message')
    @box = "info"
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
      format.xml  {render :xml => @message}
      format.xml  {render :xml => @box}
    end
  end
  
  
  # def text_message
  #   @user = current_user
  #   UserMailer.send_next_time(@user).deliver
  # end

end
