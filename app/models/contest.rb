class Contest < ActiveRecord::Base
  has_one :league
  has_many :teams, :through => :contest_teams
  has_many :contest_teams
  
  validates_presence_of :short_name
  validates_presence_of :name
end
