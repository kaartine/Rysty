class UsersController < ApplicationController

  def login
    @user = User.new
    @user.username = params[:username]
  end

  def process_login
    if user = User.authenticate(params[:user])
      session[:id] = user.id # Remember the user's id during this session
      set_rights(user)
      if session[:return_to] != nil
        redirect_to session[:return_to]
      else
        redirect_to root_path
      end
    else
      flash[:error] = 'Invalid login.'
      redirect_to :action => 'login', :username => params[:user][:username]
    end
  end

  def logout
    reset_session
    flash[:message] = 'Logged out.'
    redirect_to :controller => 'home'
  end

  def my_account
    @user = User.find(session[:id])
    @person = Person.find(@user.person_id)
  end

end
