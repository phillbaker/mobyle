require 'digest/sha2'

class Hub
  include DataMapper::Resource
  self.raise_on_save_failure = true
  
  property :id, Serial
  timestamps :at
  
  property :name, String
  property :mobile_footer, String, :length => 255
  
  property :private_seed, String
  property :private_id, String, :length => 64
  
  belongs_to :user
  has n, :groups#TODO, :dependent => :destroy
  
  before :create, :create_private_id
  
  def create_private_id
    # Generate a random number as the seed
    self.private_seed = rand(10**10)
    # Use the has of the random number + object id
    self.private_id = Digest::SHA2.new.update("#{self.private_seed}#{self.id}").to_s
  end
  
  def private_link
    # Create private link from private id, this should match the route in config/routes.rb
    "m/#{self.private_id}"
  end
end
