class UsersController < ApplicationController
  before_filter :login_required, :except => [:login, :show, :process_login]

  def login
    @user = User.new
    @user.username = params[:username]
  end

  def process_login
    flash[:error] = 'Invalid loginsss.'
    if user = User.authenticate(params[:user])
      session[:id] = user.id # Remember the user's id during this session
      set_rights(user)
      if session[:return_to] != nil
        redirect_to session[:return_to]
      else
        redirect_to '/'
      end
    else
      flash[:error] = 'Invalid login.'
      redirect_to :action => 'login', :username => params[:user][:username]
    end
  end

  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :controller => '/'
  end

  def my_account
    @user = User.find(session[:id])
    @person = Person.find(@user.person_id)
  end

  def set_rights(user)
    session[:admin] = user.admin
    session[:add_edit_delete] = user.add_edit_delete
    session[:intranet] = user.intranet
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
          format.html { redirect_to(session[:return_to] || '/') }
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

    @user.password = ''
  end

  def update
    @user = User.find(params[:id])
    @person = Person.find(@user.person_id)

    if params[:user][:password].blank?
      params[:user].delete("password")
    end

    respond_to do |format|
      if @person.update_attributes(params[:person]) & @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.' + params[:user].to_s + ' ' + @user.password
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    begin
      @user = User.find(params[:id])
      @person = Person.find(@user.person_id)

      @user.password = ''

      respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end

    rescue
      flash[:notice] = 'User ID ' + params[:id].to_s + ' was not found.'
      redirect_to :controller => '/login'
    end

  end
end
