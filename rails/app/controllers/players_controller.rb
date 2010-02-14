class PlayersController < ApplicationController
  def index
    @person = Person.find(params[:person_id])
    @players = @person.players
  end

  def show
    @person = Person.find(params[:person_id])
    @players = @person.players.find(params[:id])
  end

  def new
  end

  def edit
  end

end
