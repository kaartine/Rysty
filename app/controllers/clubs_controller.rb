class ClubsController < ApplicationController

  def show
    @club = Club.find(params[:id])
  end

  def index
    @clubs = Club.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @club }
    end
  end

end
