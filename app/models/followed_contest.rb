class FollowedContest < ActiveRecord::Base
  has_one :user
  has_one :contest
  
  validates_presence_of :user_id, :contest_id
end