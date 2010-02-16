class PlayersController < ApplicationController

  def index 
    @person = Person.find(params[:person_id])  
    @players = @person.players 
  end  
   
  def show 
    @person = Person.find(params[:person_id])  
    @player = @person.players.find(params[:id])  
  end  
  
  def new 
    @person = Person.find(params[:person_id]) 
    @player = 
    @person.players.build 
  end  
    
  def create 
    @person = Person.find(params[:person_id])  
    @player = @person.players.build(params[:player])  
    
    if @player.save 
      redirect_to person_player_url(@person, @player)  
    else  
      render :action => "new"  
    end
  end  
   
  def edit 
    @person = Person.find(params[:person_id])  
    @player = @person.players.find(params[:id])  
  end  
   
  def update 
    @person = Person.find(params[:person_id])  
    @player = Player.find(params[:id])  
   
    if @player.update_attributes(params[:player])  
      redirect_to person_player_url(@person, @player) 
    else  
      render :action => "edit"  
    end  
  end  
    
  def destroy 
    @person = Person.find(params[:person_id])  
    @player = Player.find(params[:id])  
    @player.destroy respond_to do |format| 
      format.html { redirect_to person_players_path(@person) } 
      format.xml { head :ok } 
    end  
  end
 
end 