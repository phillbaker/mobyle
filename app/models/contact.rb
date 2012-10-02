class Contact
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
  
  property :name, String
  property :telephone, Integer #TODO make sure we have 10 digits
  property :email, String
  
  belongs_to :group
  
  before :valid?, :format_telephone
  
  def format_telephone
    # Remove non-numeric characters
    self.telephone = self.telephone.gsub(/[^0-9]*/, '')
  end
end
