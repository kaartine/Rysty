class Admin::AdminController < ApplicationController
  # login is always needed
  
  before_filter :admin_login_required
  
  def admin_login_required
    login_required(is_admin)
  end
 
  def is_admin
    session[:admin]
  end

end