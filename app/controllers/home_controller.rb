class HomeController < ApplicationController
  def index
    if current_user != nil && user_signed_in?
      @user = current_user
    	if current_user.hubs.size > 0
    		@hubs = current_user.hubs
  		end
		end
  end
end
