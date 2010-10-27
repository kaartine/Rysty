# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include SslRequirement

  helper :all # include all helpers, all the time
 
  layout :choose_layout
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  #:secret => '37e09a798012ce8994483215db76b856'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :set_user
  
  before_filter :set_locale

protected
  def set_user
    begin    
      @user = User.find(session[:id]) if @user.nil? && session[:id]
    rescue
      reset_session
    end
  end

  def login_required(access = nil)
    if(access.nil?)
      return true if @user
    else
      return true if access
      access_denied_to_this_site
      return false
    end
    access_denied
    return false
  end
  
  def access_denied
    session[:return_to] = request.request_uri
    flash[:error] = t('t_no_permission')
    redirect_to :controller => '/users', :action => 'login'
  end
  
  def access_denied_to_this_site
    puts "site"
    session[:return_to] = request.request_uri
    redirect_to :controller => '/'
  end
  
  def set_locale 
    # if params[:locale] is nil then I18n.default_locale will be used
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = params[:locale]
    else
      I18n.locale = session[:locale]
    end
  end
  
  def choose_layout 
    logger.debug "application.rb debug trace"   
    if [ 'admin' ].include? action_name
      'admin'
    else
      'main'
    end
  end
  
  def set_rights(user)
      session[:admin] = User.find(user.id).admin
      session[:club_admin] = ClubAdmin.exists?(['user_id = ?',user.id])
      session[:league_admin] = LeagueAdmin.exists?(['user_id = ?',user.id])
      session[:team_admin] = TeamAdmin.exists?(['user_id = ?',user.id])
      session[:contest_admin] = ContestAdmin.exists?(['user_id = ?',user.id])
  end

end
