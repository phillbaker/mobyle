require 'dm-rails/middleware/identity_map'

# Monkey patch to make DM implementation match AR #TODO this is probably not the best place for this
module CanCan
  module ModelAdapters
    class DataMapperAdapter
      def self.find(model_class, id)
        model_class.get!(id) # Use bang to trigger DataMapper::ObjectNotFoundError on non-exisiting objects
      end
    end
  end
end

class ApplicationController < ActionController::Base
  use Rails::DataMapper::Middleware::IdentityMap
  protect_from_forgery
  
  before_filter :authenticate_user!
  check_authorization :unless => :devise_controller?
  before_filter do 
    @title = 'Mobyle'
  end

  def append_title appendage
    @title += " | "
    @title += appendage.to_s
  end
  
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
