class ContestsController < ApplicationController
  
  def index
    @season = APP_CONFIG["current_season"] if @season.nil?        
    @season = params[:season] if !params[:season].nil?
      
    if params[:contest].nil? && session[:user_contest_id].nil?
      @contest = Contest.first(:conditions => ["season = ?",@season], :include => :teams)
    elsif !params[:contest].nil?
      @contest = Contest.find(params[:contest][:id], :include => :teams)
    else
      @contest = Contest.find(session[:user_contest_id], :include => :teams)
    end
    
    session[:user_contest_id] = @contest.id
     
    calculate_team_points(@contest.id)
    
    @games = Game.all(:conditions => ['contest_id = ? AND played <> true', @contest.id], :limit => '5')
  end
  
  def show
    @contest = Contest.find(params[:id], :include => :teams)
    calculate_team_points(params[:id])
      
    session[:user_contest_id] = params[:id]
  end
  
  private
  def calculate_team_points(contest_id)
    for team in @contest.teams
      team.calculate_points(contest_id, team.id)
    end
    
    @contest.teams.sort! { |a, b| b.points <=> a.points }    
  end
end
