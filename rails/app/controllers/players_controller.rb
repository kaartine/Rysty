class PlayersController < ApplicationController

  before_filter :find_person_and_player,
    :only => [:show, :edit]

  def index 
    @person = Person.find(params[:person_id])  
    @players = @person.players 
  end  
   
  def show
  end
        
  private
  def find_person_and_player
    @person = Person.find(params[:person_id])
    @player = @person.players.find(params[:id])
  end
 
end 