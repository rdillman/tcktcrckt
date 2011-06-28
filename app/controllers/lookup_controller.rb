class LookupController < ApplicationController
  
  
  def addr
    @usr_qry = params[:q]
    @user = current_user
    
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
        @message = 'Next Streetclean:'<<@results[0][0].strftime("%A %B %e at %I:%M%p.")
        @box = "info"
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
      
    else
      if @user
        @alerts = Alarm.where("user_id =?",@user.id)
        @recs = []
        @recs << @user.rec1 <<@user.rec2<<@user.rec3
      end
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/app/views/lookup/addr.html.erb"}
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
  
  
  def do_empty
    @user = current_user
    if @user
      @alerts = Alarm.where("user_id =?",@user.id)
      @recs = []
      # What does rec1, rec2, rec3 mean??? What does recs mean??
      @recs << @user.rec1 <<@user.rec2<<@user.rec3
    end
    @message = "Please enter something"
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
    @user  = current_user
    @message = res
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
    @message = @results
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
    
    @message = "We have mulitple streets with that name, try adding St or Ave to your search"
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
    @message = "Please enter something"
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
