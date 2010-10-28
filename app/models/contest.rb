class Contest < ActiveRecord::Base
  belongs_to :followed_contests

  has_many :contest_admins
  has_many :games
  has_one :league
  
  has_many :contest_teams
  has_many :teams, :through => :contest_teams
  
  attr_accessor :followed_contests_id
  
  validates_presence_of :short_name
  validates_presence_of :name
end
