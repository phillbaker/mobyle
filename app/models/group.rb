class Group
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
  
  property :name, String
  
  has n, :contacts
  belongs_to :hub
  is :tree, :order => :name
  
  # prevent saving Group as child of self, except when new?
  validates_with_method :parent_id,
                        :method => :category_cannot_be_made_a_child_of_self,
                        :unless => :new?
  
  protected

    def category_cannot_be_made_a_child_of_self
      if self.id === self.parent_id
        return [
          false,
          "A Category [ #{self.name} ] cannot be made a child of it self [ #{self.name} ]"
        ]
      else
        return true
      end
    end
end
