class ContestsController < ApplicationController
  
  def index
    @season = APP_CONFIG["current_season"] if @season.nil?        
    @season = params[:season] if !params[:season].nil?
      
    if params[:contest].nil?
      @contest = Contest.first(:conditions => ["season = ?",@season], :include => :teams)
    else
      @contest = Contest.find(params[:contest][:id], :include => :teams)
    end
     
    calculate_team_points(@contest.id)
    
    @games = Game.all(:conditions => ['contest_id = ? AND winner_id IS NULL AND draw IS NULL', @contest.id], :limit => '5')
      puts "fame cout" + @games.count.to_s +  ' ' + @contest.id.to_s
  end
  
  def show
    @contest = Contest.find(params[:id], :include => :teams)
    calculate_team_points(params[:id])
  end
  
  private
  def calculate_team_points(contest_id)
    for team in @contest.teams
      team.calculate_points(contest_id, team.id)
    end
    
    @contest.teams.sort! { |a, b| b.points <=> a.points }    
  end
end
