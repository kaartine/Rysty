require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  fixtures :users
  
  test "should go to login page" do
    get :index
    assert_response (:redirect)
    assert_nil assigns(:users)
  end   

  test "should return users" do
    get :index
    assert_response (:redirect)
    login_as(:admin)
    get :index
    assert_response (:success)
    assert_not_nil assigns(:users)
  end
  
#  module AuthenticatedTestHelper
    def login_as(user)
      @request.session[:id] = users(user).id
    end
#  end
end
