class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  
  # protected
  # def current_user
  #   #Note changed from session_id cuz that didn't work
  #   @current_user ||= User.find_by_id(session[])
  # end
  # 
  # def signed_in?
  #   !!current_user
  # end
  # 
  # helper_method :current_user, :signed_in?
  # 
  # def current_user=(user)
  #   @current_user = user
  #   session[:user_id] = user.id
  # end
  
end
