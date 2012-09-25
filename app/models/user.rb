class User
  include DataMapper::Resource
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:invitable, (not dm-compatible)
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  property :email,              String, :required => true, :default => "", :length => 255
  property :encrypted_password, String, :required => true, :default => "", :length => 255

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
  # property :confirmation_token,   String
  # property :confirmed_at,         DateTime
  # property :confirmation_sent_at, DateTime
  # property :unconfirmed_email,    String # Only if using reconfirmable

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

  #TODO why aren't these default?
  property :id, Serial
  property :created_at, DateTime
  property :created_on, Date
  property :updated_at, DateTime
  property :updated_on, Date
  
  has n, :hubs
  
end
