class ContestTeam < ActiveRecord::Base
  belongs_to :contest
  belongs_to :team
end