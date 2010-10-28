class LoginRequired::ContestAdminsController < LoginRequired::LoginRequiredController
  
  def index
    #@contests = Contest.all(:order => "short_name ASC", :conditions => ['id IN (SELECT id FROM contest_admins WHERE user_id = ?)', session[:id]])
    @contests = Contest.all(:order => "short_name ASC", :include => [:contest_admins] , :conditions => ['contest_admins.user_id = ?', session[:id]])
  end
  
  def new
    @game = Game.new
    @teams = Team.all(:order => "short_name ASC", :include => [:contest_teams], 
      :conditions => ['season = ? AND contest_teams.id = ?', 2010, params[:id]])
  end
end
