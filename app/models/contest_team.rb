class ContestTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :contest
end
