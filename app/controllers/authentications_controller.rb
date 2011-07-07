class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    auth = request.env["rack.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    debugger
    #flash[:notice] = i18n.translate('authentications_controller.flash.auth_success')
    redirect_to authentications_url
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    #flash[:notice] = i18n.translate('authentications_controller.flash.auth_destroyed')
    redirect_to authentications_url
  end
end
