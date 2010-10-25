class Team < ActiveRecord::Base
  has_one :contact_info
  has_one :club
  
  def points(contest, id)
    points = Game.all(:conditions => ['contest_id = ? AND winner = ?', contest, id])
    points.nil? ? points : 0
  end
end
