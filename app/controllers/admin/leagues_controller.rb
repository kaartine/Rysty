class Admin::LeaguesController < Admin::AdminController

  def new
    @league = League.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @league }
    end
  end

  def edit
    @leagues = League.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @league }
    end
  end

  def show
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])

    if @league.update_attributes(params[:club])
      redirect_to club_url(@league)
    else
      render :action => "edit"
    end
  end

  def index
    @leagues = League.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # POST /club
  # POST /club.xml
  def create
    @league = League.new(params[:club])

    respond_to do |format|
      if @league.save
        flash[:notice] = t(:t_league) + t(:t_created)
        format.html { redirect_to(@league) }
        format.xml  { render :xml => @league, :status => :created, :location => @league }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

end
