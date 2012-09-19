class Hub
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
  
  property :name, String
  
  belongs_to :user
  has n, :groups
end
