class Admin::ContestsController < Admin::AdminController
  
  def show
  end
  
  def new
    @contest = Contest.new
  end
  
  def create
    @contest = Contest.new(params[:contest])
     
    respond_to do |format|
      if @contest.valid?
      
        Contest.transaction do
          @contest.save!
      
          flash[:notice] = t(:t_contest) + " " + t(:t_was_successfully_created)
          format.html { redirect_to(admin_contests_url) }
          format.xml  { render :xml => @contest, :status => :created, :location => @contest }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contest.errors, :status => :unprocessable_entity }
      end
    end
  end
end
