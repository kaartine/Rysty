class LoginRequired::FollowedContestsController < LoginRequired::LoginRequiredController
  
  def new
    @followed_contest = FollowedContest.new 
  end
  
  def show
  end
  
  def create
    @followed_contest = FollowedContest.new(params[:followed_contest])
      
    respond_to do |format|
      @followed_contest.user_id = session[:id]
      
      if @followed_contest.valid?
      
        Contest.transaction do
          @followed_contest.save!
      
          flash[:notice] = t(:t_followed_contest) + " " + t(:t_was_successfully_created)
          format.html { redirect_to(admin_contests_url) }
          format.xml  { render :xml => @followed_contest, :status => :created, :location => @followed_contest }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @followed_contest.errors, :status => :unprocessable_entity }
      end
    end
  end
end
