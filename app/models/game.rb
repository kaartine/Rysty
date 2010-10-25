class Game < ActiveRecord::Base
  validates_presence_of :contest_id
  validates_presence_of :home_team_id
  validates_presence_of :guest_team_id
end