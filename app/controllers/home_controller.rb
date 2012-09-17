class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_authorization_check
  
  def index
    if current_user != nil && user_signed_in?
      @user = current_user
    	if current_user.hubs.size > 0
    		@hubs = current_user.hubs
  		end
		end
  end
end
