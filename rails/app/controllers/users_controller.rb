class UsersController < ApplicationController
  before_filter :login_required, :only => [:my_account, :add]
  
  def login
    @user = User.new
    @user.user_name = params[:user_name]
  end

  def process_login
    if user = User.authenticate(params[:user])
      session[:id] = user.id # Remember the user's id during this session
      set_rights(user)
      redirect_to session[:return_to] || '/'
    else
      flash[:error] = 'Invalid login.'
      redirect_to :action => 'login', :user_name => params[:user][:user_name]
    end
  end

  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :controller => '/'
  end

  def my_account
  end

  def set_rights(user)
    session[:admin] = user.admin
#    session[:id][:] = user.
#    session[:id][:] = user.
  end

  def add
    @user = User.new
    @person = Person.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :controller => '/'
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
    end
  end
end 
