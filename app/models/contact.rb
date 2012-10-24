class Contact
  include DataMapper::Resource
  self.raise_on_save_failure = true

  property :id, Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  
  property :name, String
  property :telephone, Integer #TODO make sure we have 10 digits, but also make sure we can leave it blank
  property :email, String
  
  belongs_to :group
  
  before :valid?, :format_telephone
  
  def format_telephone
    # Remove non-numeric characters
    self.telephone = self.telephone.to_s.gsub(/[^0-9]*/, '')
  end
  
  class << self
    # Return an array of hashes, parsed from tab delimited, new line separated columns and rows.
    # 
    # This method looks for name, telephone and email fields in a variety of ways.
    #
    #  For larger files, this isn't going to work, we make several copies of the array in memory
    #   we could stream the text file, separate by lines, do something more efficient.
    def parse_tab_delimited text = ''
      return [] if text.blank?
      # Hold the field numbers for each row, prepare for first/last name separate
      structure = { :name => [], :telephone => nil, :email => 0 } 
      
      import = text.split("\n")
      # assume we have headers, assume the rest follows this pattern #TODO see if we have headers, if not, test the fields
      import.shift.split("\t").each_with_index do |field, index|
        if field =~ /name/i || field =~ /last/i || field =~ /first/i
          structure[:name] << index
        end
      
        if field =~ /phone/i
          structure[:telephone] = index
        end
      
        if field =~ /mail/i # We'll assume that mail is not mailing address...
          structure[:email] = index
        end
      end
      
      # TODO make sure that we have an adequate structure to continue with
      
      import.collect do |line|
        contact = {}
        fields = line.split("\t")
        contact[:telephone] = fields[structure[:telephone]]
        contact[:name] = structure[:name].collect{|i| fields[i] }.join(' ')
        contact[:email] = fields[structure[:email]]
        contact
      end
    end
    
    def import array_of_hashes, group
      # speed up bulk inserts via transactions, but #TODO run on delayed_job or resque
      #Contact.transaction do
        array_of_hashes.each do |hash|
          contact = Contact.new(hash)
          contact.group = group
          contact.save
        end
      #end #transaction
      #should commit itself #TODO if there's anything wrong and we throw a formatting error, where does it get reported? (And it means that the entire transaction doesn't occur - would like some atomicity)
      return true # TODO return result of transaction, until then, save should raise an error on failure
    end
    
  end
end
