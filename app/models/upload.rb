class Upload
  include ActiveModel::MassAssignmentSecurity
  include DataMapper::Resource
  include Paperclip::Resource
  self.raise_on_save_failure = true
  
  #TODO have a check for allowed file types: images, pdf, common productivity files (doc, xls, etc.) based on mime type extraction
  # http://stackoverflow.com/questions/51572/determine-file-type-in-ruby
  # http://rubygems.org/gems/ruby-imagespec
  
  attr_accessible :upload
  
  property :id, Serial
  property :name, String
  property :upload_file_name, String
  property :upload_content_type, String
  property :upload_file_size, Integer
  property :upload_updated_at, DateTime
  
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # Turn on Single Table Inheritance (STI)
  property :type, Discriminator, :required => false
  
  has_attached_file :upload, :whiny => false
  
  before :create do
    self.name = File.basename(self.upload_file_name, '.*') # Default initial name
  end
  
  def to_jq_upload
    {
      :name => self.upload_file_name(),
      :size => self.upload_file_size(),
      :url => self.upload.url(:original),
      :delete_url => nil, # Paths not accessible in model, fill it in when we get to the controller: #upload_path(@upload),
      :delete_type => 'DELETE'
    }
  end
  
end

class Avatar < Upload; end #TODO Class for (only) images associated with Contacts; belongs_to :User