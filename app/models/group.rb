class Group
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  
  has n, :contacts
  belongs_to :hub
end
