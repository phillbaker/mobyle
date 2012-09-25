class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_authorization_check
  
   # GET /
  def index
    @is_home = true
    if current_user != nil && user_signed_in?
      @user = current_user
    	if current_user.hubs.size > 0
    		@hubs = current_user.hubs
  		end
		else
		  @user = User.new # create new user for e-mail signup form #redirect to registration or something?
		end
  end
end
