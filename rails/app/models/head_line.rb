class HeadLine < ActiveRecord::Base
  validates_presence_of :person_id
  belongs_to :person
  
  def days_from_creation
    created_at.strftime('%a %d %b %Y, %I:%M%p') unless created_at.nil?
  end
end
