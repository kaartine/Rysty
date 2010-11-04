require "sha1"

class User < ActiveRecord::Base
  has_many :club_admins
  has_many :clubs, :through => :club_admins
  has_many :followed_contests
    
  validates_uniqueness_of :username
  validates_confirmation_of :password_clear,
      :if => lambda { |user| user.new_record? or !user.changes['password_clear'].nil? }
  validates_length_of :password_clear, :within => 5..40,
      :if => lambda { |user| user.new_record? or not user.password.blank? }
        
  attr_accessor :password_clear
      
  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password == user.hashed(user.salt.to_s + password)
      return user
    end
  end
  
private
  before_save :update_password

  # Updates the hashed_password if a plain password was provided.
  def update_password
    hashed_pass = encrypt_password
    if hashed_pass != self.password
      self.password = hashed_pass
    end
  end
  
  def salt_generator(len)
    numbers = ("0".."9").to_a
    newrand = ""
    1.upto(len) { |i| newrand << numbers[rand(numbers.size - 1)] }
    return newrand
  end

  def encrypt_password
    if (self.salt == nil or self.salt.blank? )
      self.salt = salt_generator(40)
    end

    hashed(self.salt.to_s + self.password_clear)
  end
    
  def hashed(str)
    SHA1.new(str).to_s
  end 

end

