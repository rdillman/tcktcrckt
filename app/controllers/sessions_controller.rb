class SessionsController < ApplicationController
  before_filter :authenticate_user!
  
  class SessionsController < ApplicationController
    def create
      render :text => request.env['rack.auth'].inspect
      unless @auth = Authorization.find_from_hash(auth)
        # Create a new user or add an auth to existing user, depending on
        # whether there is already a user signed in.
        @auth = Authorization.create_from_hash(auth, current_user)
      end
      # Log the authorizing user in.
      self.current_user = @auth.user

      render :text => I18n.translate('sessions_controller.welcome') "#{current_user.name}."
    end
  end
  
end
