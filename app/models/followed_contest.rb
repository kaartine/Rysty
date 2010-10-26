class FollowedContest < ActiveRecord::Base
  has_one :user
  belongs_to :contest
  
  validates_presence_of :user_id, :contest_id

end