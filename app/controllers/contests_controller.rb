class ContestsController < ApplicationController
  
  def index
    
  end
  
  def show
    @contest = Contest.find(params[:id], :include => :teams)
  end
end