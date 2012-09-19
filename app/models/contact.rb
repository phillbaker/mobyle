class Contact
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
  
  property :name, String
  property :telephone, Integer
  
  belongs_to :group
end
