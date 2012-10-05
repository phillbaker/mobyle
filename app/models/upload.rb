class Upload
  include ActiveModel::MassAssignmentSecurity
  include DataMapper::Resource
  include Paperclip::Resource
  self.raise_on_save_failure = true
  
  attr_accessible :upload
  
  property :id, Serial
  property :name, String
  property :upload_file_name, String
  property :upload_content_type, String
  property :upload_file_size, Integer
  property :upload_updated_at, DateTime
  
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
  
  # Turn on Single Table Inheritance (STI)
  property :type, Discriminator
  
  has_attached_file :upload, :whiny => false
  
  before :create do
    self.name = self.upload_file_name # Default initial name
  end
  
end

class FileUpload < Upload; end # Class for uploads associated with Groups; belongs_to :group, group: has n, :file_uploads
class Avatar < Upload; end # Class for images associated with Contacts; belongs_to :