class Contest < ActiveRecord::Base
  has_one :league
  has_many :teams, :through => :contest_teams
  has_many :contest_teams
  belongs_to :followed_contests
  
  attr_accessor :followed_contests_id
  
  validates_presence_of :short_name
  validates_presence_of :name
end
