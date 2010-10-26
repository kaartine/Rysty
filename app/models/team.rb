class Team < ActiveRecord::Base
  has_one :contact_info
  has_one :club
  
  attr_accessor :points, :wins, :draws, :games, :losts, :goals_for, :goals_against 
  
  def calculate_points(contest, id)
    @games = Game.all(:conditions => ['contest_id = ? AND (home_team_id = ? OR guest_team_id = ?)', contest, id, id]).count
    @wins = Game.all(:conditions => ['contest_id = ? AND winner_id = ?', contest, id]).count
    @draws = Game.all(:conditions => ['contest_id = ? AND (home_team_id = ? OR guest_team_id = ?) AND draw = TRUE', contest, id, id]).count
    @points = wins * APP_CONFIG['points_from_win'] + draws * APP_CONFIG['points_from_draw']
    @losts = @games - @wins - @draws
    @goals_for = 0
    @goals_against = 0
    
    Game.all(:conditions => ['contest_id = ? AND (home_team_id = ? OR guest_team_id = ?)', contest, id, id]).collect { |p|
      if !p.winner_id.nil? || p.draw
        if p.home_team_id == id
          @goals_for += p.home_goals
          @goals_against += p.guest_goals
        else
          @goals_for += p.guest_goals
          @goals_against += p.home_goals
        end
      end
    }
  end
  
end
