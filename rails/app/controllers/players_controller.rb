class PlayersController < ApplicationController
  def index
    @person = Pearson.find(params[:person_id])  
    @players = @person.players 
  end

  def show
    @person = Pearson.find(params[:person_id])  
    @players = @person.players.find(params[:id]) 
  end

  def new
  end

  def edit
  end

end
