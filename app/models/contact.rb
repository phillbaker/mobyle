class Contact
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :telephone, Integer
  
  belongs_to :hub
end
