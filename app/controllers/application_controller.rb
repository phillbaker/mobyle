require 'dm-rails/middleware/identity_map'
class ApplicationController < ActionController::Base
  use Rails::DataMapper::Middleware::IdentityMap
  protect_from_forgery
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
