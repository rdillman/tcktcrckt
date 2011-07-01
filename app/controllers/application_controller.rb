class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile, :set_user_language
  # def localize_time_strings(time)
  #   locale_time = I18n.localize(Chronic.parse(time)) 
  #   locale_time.strftime(I18n.translate('time.formats.default'))
  # end
  
  def validated?
    @user = current_user
    if !@user
      return 0
    elsif @user.phone_number != @user.valphone
      return 1
    else
      return 2
    end
  end
  private
  def set_user_language
    I18n.locale = current_user.language if user_signed_in?
  end
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent.to_s.downcase =~ /palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|mobile/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
  def validated?
    @user = current_user
    if !@user
      return 0
    elsif @user.phone_number != @user.valphone
      return 1
    else
      return 2
    end
  end
    
end
