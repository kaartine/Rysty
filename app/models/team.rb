class Team < ActiveRecord::Base
  has_one :contact_info
  has_one :club
  
  attr_accessor :points, :wins, :draws, :games, :losts
  
  def calculate_points(contest, id)
    @games = Game.all(:conditions => ['contest_id = ? AND (home_team_id = ? OR guest_team_id = ?)', contest, id, id]).count
    @wins = Game.all(:conditions => ['contest_id = ? AND winner_id = ?', contest, id]).count
    @draws = Game.all(:conditions => ['contest_id = ? AND (home_team_id = ? OR guest_team_id = ?) AND draw = TRUE', contest, id, id]).count
    @points = wins * APP_CONFIG['points_from_win'] + draws * APP_CONFIG['points_from_draw']
    @losts = @games - @wins - @draws 
  end
  
  
end
