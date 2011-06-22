class ValidatorController < ApplicationController
  before_filter :authenticate_user!
  
  def val
    @code = params[:code].to_i
    @user = current_user
    
    if @code != nil && @code == @user.valcode
      @user.update_attribute(:valphone, @user.phone_number)
    
    else
      #render incorrect
      @message = "Incorrect Code, Please Try Again"
      @box = "error"
      respond_to do |format|
        format.html {render :file => "#{Rails.root}/app/views/validator/enter.html.erb"}
        format.xml  { render :xml => @message }
        format.xml  { render :xml => @box }
      end
    end
  end

  def enter
    @user = current_user
    @validation_code = @user.valcode
    if !@validation_code
      #Create Validation Code
      new_val_code = rand(999)
      @user.update_attribute(:valcode,new_val_code)
      UserMailer.send_val_code(@user,new_val_code)
    end
    @phone = @user.phone_number
    respond_to do |format|
      format.html
      format.xml {render :xml => @phone}
    end
    
  end

end
