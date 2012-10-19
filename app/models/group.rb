class Group
  include DataMapper::Resource
  self.raise_on_save_failure = true
  
  property :id, Serial
  timestamps :at
  
  property :name, String
  
  belongs_to :hub
  has n, :contacts#TODO, :dependent => :destroy
  has n, :file_uploads#TODO, :dependent => :destroy
  
  is :tree, :order => :name
  
  # prevent saving Group as child of self, except when new
  validates_with_method :parent_id,
                        :method => :cannot_be_made_a_child_of_self,
                        :unless => :new?
  
  # A convenience accessor for all of the types of objects that belong to this group
  def items
    children().to_a + contacts().to_a + file_uploads().to_a
  end
  
  protected

    def cannot_be_made_a_child_of_self
      if self.parent_id != nil && self.id === self.parent_id
        error = "A #{self.class.name.titelize} [ #{self.name} ] cannot be made a child of it self [ #{self.name} ]"
        #self.errors << 
        errors.add(:parent_id, error)
        return [false, error]
      else
        return true
      end
    end
end
