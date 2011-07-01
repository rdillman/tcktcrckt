class ValidatorController < ApplicationController
  before_filter :authenticate_user!
  
  def val
    @user = current_user
    if @user.phone_number
      @code = params[:code].to_i
      @user = current_user
    
      if @code != nil && @code == @user.valcode
        @user.update_attribute(:valphone, @user.phone_number)
    
      else
        #render incorrect
        @message =  I18n.translate('validator_controller.incorrect_code')
        @box = "error"
        respond_to do |format|
          format.html {render :file => "#{Rails.root}/app/views/validator/enter.html.erb"}
          format.xml  { render :xml => @message }
          format.xml  { render :xml => @box }
        end
      end
    end
  end

  def enter
    @user = current_user
    @validation_code = @user.valcode
    if !@validation_code
      #Create Validation Code
      new_val_code = rand(10000)
      if new_val_code < 1000
        new_val_code = new_val_code +1000
      end
      @user.update_attribute(:valcode,new_val_code)
      debugger
      UserMailer.send_val_code(@user,new_val_code).deliver
      debugger
    end
    @phone = @user.phone_number
    respond_to do |format|
      format.html
      format.xml {render :xml => @phone}
    end
    
  end

end
