require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  fixtures :users
  
  test "go to login page" do
    get :index
    assert_response (:redirect, "need to login first")
    assert_nil assigns(:users, "list of users was returned even though we were not logged in")
  end   

  test "return users" do
    get :index
    login_as(:admin)
    get :index
    assert_response (:success, "login was not success")
    assert_not_nil assigns(:users, "no users were returned")
  end
  
#  module AuthenticatedTestHelper
    def login_as(user)
      @request.session[:id] = users(user).id
    end
#  end
end
