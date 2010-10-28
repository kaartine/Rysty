class LoginRequired::GamesController < LoginRequired::LoginRequiredController
  
  def index
  end
  
  def new
    @game = Game.new
    @teams = Team.all(:order => "short_name ASC", :conditions => ['season = ?', 2010])
  end
end
