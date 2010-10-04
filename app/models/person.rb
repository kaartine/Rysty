class Person < ActiveRecord::Base
   validates_presence_of :first_name, :last_name
   has_many :players
   has_many :posts
   belongs_to :user
   
   def full_name
    [first_name.capitalize, last_name.capitalize].compact.join(' ')
   end
end
