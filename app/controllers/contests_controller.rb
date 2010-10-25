class ContestsController < ApplicationController
  
  def index
    
  end
  
  def show
    @contest = Contest.find(params[:id], :include => :teams)
    for team in @contest.teams
      team.calculate_points(params[:id], team.id)
    end
    
    @contest.teams.sort! { |a, b| b.points <=> a.points }
  end
end