class Admin::AdminController < ApplicationController
  # login is always needed
  before_filter :login_required
 
end