class LoginRequired::FollowedContestsController < LoginRequired::LoginRequiredController
  
  def new
    @followed_contest = FollowedContest.new 
    
    if @season.nil?
      @season = APP_CONFIG['current_season']
    end
  end
  
  def show
  end
  
  def destroy
    @followed_contest = FollowedContest.find(params[:id])
    @followed_contest.destroy

    respond_to do |format|
      format.html { redirect_to('/') }
      format.xml  { head :ok }
    end
  end
  
  def create
    @followed_contest = FollowedContest.new(params[:followed_contest])
      
    respond_to do |format|
      @followed_contest.user_id = session[:id]
      
      if @followed_contest.valid?
      
        Contest.transaction do
          @followed_contest.save!
      
          flash[:notice] = t(:t_followed_contest) + " " + t(:t_was_successfully_added)
          format.html { redirect_to(login_required_followed_contests_url) }
          format.xml  { render :xml => @followed_contest, :status => :created, :location => @followed_contest }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @followed_contest.errors, :status => :unprocessable_entity }
      end
    end
  end
end
