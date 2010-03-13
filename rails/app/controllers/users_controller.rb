class UsersController < ApplicationController
  before_filter :login_required, :only => [:my_account, :add]
  
  def login
    @user = User.new
    @user.username = params[:username]
  end

  def process_login
    if user = User.authenticate(params[:user])
      session[:id] = user.id # Remember the user's id during this session
      set_rights(user)
      redirect_to session[:return_to] || '/'
    else
      flash[:error] = 'Invalid login.'
      redirect_to :action => 'login', :user_name => params[:user][:username]
    end
  end

  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :controller => '/'
  end

  def my_account
    @user = User.find(session[:id])
  end

  def set_rights(user)
    session[:admin] = user.admin
  end

  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def new
    @user = User.new
    @person = Person.new
#    @person = Person.new
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def create
    @person = Person.new(params[:person])
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @person.valid? & @user.valid?
        User.transaction do
          @person.save!
          @user.person_id = @person.id
          @user.save!
          
          flash[:notice] = 'User was successfully created.'
          format.html { redirect_to(@user) }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
        end        
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @person = Person.find(@user.person_id)
  end
  
  def update
    @user = User.find(params[:id])
    @person = Person.find(@user.person_id)

    respond_to do |format|
      User.transaction do
        @person.update_attributes!(params[:person])
        @user.update_attributes!(params[:user])

        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      end
      format.html { render :action => "edit" }
      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
    end
  end
  
  def show
    @user = User.find(params[:id])
    @person = Person.find(@user.person_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end
end 
