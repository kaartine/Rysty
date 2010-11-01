class LoginRequired::GamesController < LoginRequired::LoginRequiredController
  
  def index
    @games = Game.all(:conditions => ['contest_id = ?', params[:contest_id]]).order(:when)
  end
  
  def new
    @game = Game.new()
    @teams = Team.all(:order => "short_name ASC", :conditions => ['season = ?', 2010])
    @game.contest_id = params[:contest_id]
  end
  
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.valid?
        Game.transaction do
          @game.save!
                      
          flash[:notice] = t(:t_game) + " " + t(:t_was_successfully_created)
          format.html { redirect_to(login_required_contest_admins_path) }
          format.xml  { render :xml => @game, :status => :created, :location => @game }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
end
