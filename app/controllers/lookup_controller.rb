class LookupController < ApplicationController
  before_filter :authenticate_user!, :except => :addr
  
  
  def addr
  end

  def map
  end
  
  # def text_message
  #   @user = current_user
  #   UserMailer.send_next_time(@user).deliver
  # end

end
