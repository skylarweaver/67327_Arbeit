class User < ActiveRecord::Base
  # Specify fields that can be accessible through mass assignment (not password_digest)
  attr_accessor :password, :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :active, :role
  
  # Use built-in rails support for password protection
  # has_secure_password
  before_create :set_password_digest
    
  # Relationships
  # -----------------------------
  has_many :assignments
  has_many :projects, :through => :assignments
  has_many :completed_tasks, :class_name => "Task", :foreign_key => "completed_by"
  has_many :created_tasks, :class_name => "Task", :foreign_key => "created_by"

  # Scopes
  # -----------------------------
  scope :alphabetical, order("last_name, first_name")
  scope :active,       where('active = ?', true)
  scope :inactive,       where('active = ?', false)
  
  # Validations
  # -----------------------------
  # make sure required fields are present
  validates_presence_of :first_name, :last_name, :email  
  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([a-z0-9.-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a valid format", :allow_blank => true
  validates_presence_of :password, :on => :create 
  validates_presence_of :password_confirmation, :on => :create 
  validates_confirmation_of :password, :message => "does not match"
  validates_length_of :password, :minimum => 4, :message => "must be at least 4 characters long", :allow_blank => true
  
  # Other methods
  # -----------------------------  
  def proper_name
    first_name + " " + last_name
  end
  
  def name
    last_name + ", " + first_name
  end

  # for use in authorizing with CanCan
  ROLES = [['Administrator', :admin],['Member', :member]]

  def role?(authorized_role)
    return false if role.nil?
    role.downcase.to_sym == authorized_role
  end

  # login by email address
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
  
  def update_user_attributes
    digest = self.encode_password
    query = "UPDATE users SET first_name='#{self.first_name}',last_name='#{self.last_name}',email='#{self.email}',role='#{self.role}',active='#{self.active}',password_digest='#{digest}' WHERE id=#{self.id}"
    User.connection.execute(query)
  end
  
  def self.reset_password(new_pswd, user_id)
    query = "UPDATE users SET password_digest='#{Base64.encode64(new_pswd)}' WHERE id='#{user_id}'"
    User.connection.execute(query)
  end
  
  def encode_password
    Base64.encode64(self.password)
  end
  
  def set_password_digest
    self.password_digest = encode_password
  end

end
