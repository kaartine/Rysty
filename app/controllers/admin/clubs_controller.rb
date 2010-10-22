class Admin::ClubsController < Admin::AdminController

  def new
    @club = Club.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @club }
    end
  end

  def edit
    @clubs = Club.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @club }
    end
  end

  def show
    @club = Club.find(params[:id])
  end

  def update
    @club = Club.find(params[:id])

    if @club.update_attributes(params[:club])
      redirect_to club_url(@club)
    else
      render :action => "edit"
    end
  end

  def index
    @clubs = Club.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # POST /club
  # POST /club.xml
  def create
    @club = Club.new(params[:club])

    respond_to do |format|
      if @club.save
        flash[:notice] = 'Club was successfully created.'
        format.html { redirect_to(@club) }
        format.xml  { render :xml => @club, :status => :created, :location => @club }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

end
