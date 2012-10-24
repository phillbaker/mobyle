class User
  include DataMapper::Resource
  # Don't do for devise-handled stuff: 
  self.raise_on_save_failure = true
  
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :invitable,
         :recoverable, :rememberable, :trackable, :confirmable, :validatable

  ## Database authenticatable
  property :email,              String, :required => true, :default => "", :length => 255 
  property :encrypted_password, String, :default => "", :length => 255 #Not :required => true, b/c then it's a NOT NULL field and we won't be able to save

  ## Recoverable
  property :reset_password_token,   String
  property :reset_password_sent_at, DateTime

  ## Rememberable
  property :remember_created_at, DateTime

  ## Trackable
  property :sign_in_count,      Integer, :default => 0
  property :current_sign_in_at, DateTime
  property :last_sign_in_at,    DateTime
  property :current_sign_in_ip, String
  property :last_sign_in_ip,    String

  ## Encryptable
  property :password_salt, String#, :null => true

  ## Confirmable
  property :confirmation_token,   String
  property :confirmed_at,         DateTime
  property :confirmation_sent_at, DateTime
  property :unconfirmed_email,    String # Only if using reconfirmable

  ## Lockable
  # property :failed_attempts, Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # property :unlock_token,    String # Only if unlock strategy is :email or :both
  # property :locked_at,       DateTime

  ## Token authenticatable
  # property :authentication_token, String, :length => 255

  ## Invitable
  property :invitation_token, String, :length => 255
  property :invitation_sent_at, DateTime
  property :invitation_accepted_at, DateTime
  property :invitation_limit, Integer
  property :invited_by_id, Integer
  property :invited_by_type, String

  property :name, String
  property :admin, Boolean

  #TODO why aren't these default?
  property :id, Serial
  #timestamps :at # => this makes the timestamp columns NOT NULL in the db, that screws stuff up
  property :created_at, DateTime
  property :updated_at, DateTime
  
  has n, :hubs #TODO, :dependent => :destroy # Or :dependent => :trash
  
  # Mass assignable properties
  # attr_accessible :name, :email, ... #TODO
  
  # Devise validations, customized for invitable
  # validates_uniqueness_of   :email,     :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  # validates_format_of       :email,     :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  # validates_presence_of     :password,  :on => :create
  # validates_confirmation_of :password,  :on => :create
  # validates_length_of       :password,  :within => Devise.password_length, :allow_blank => true
  
  def admin?
    self.admin || self.id == 1 # User with ID of 1 is superuser
  end
  
end
