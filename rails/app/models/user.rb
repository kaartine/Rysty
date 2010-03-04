class User < ActiveRecord::Base 
  validates_uniqueness_of :user_name
  validates_confirmation_of :password, :on => :create
  validates_length_of :password, :within => 5..40

  # If a user matching the credentials is found, returns the User object.
  # If no matching user is found, returns nil.
  def self.authenticate(user_info)
    find_by_user_name_and_password(user_info[:user_name], user_info[:password])
  end
end 

