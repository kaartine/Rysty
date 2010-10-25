class Team < ActiveRecord::Base
  has_one :contact_info
  has_one :club
  
  def points(contest, id)
    wins = Game.all(:conditions => ['contest_id = ? AND winner = ?', contest, id]).count
    draws = Game.all(:conditions => ['contest_id = ? AND (home_team_id = ? OR guest_team_id = ?) AND draw = TRUE', contest, id, id]).count
    wins * APP_CONFIG['points_from_win'] + draws * APP_CONFIG['points_from_draw']
  end
end
