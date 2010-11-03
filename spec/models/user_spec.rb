require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
 
describe User do
  before(:each) do
    @user = User.create
    @user.admin = false
    @user.salt = '1234'
    @user.password = 'admin'
    @user.username = 'user1'
  end
 
  it "should encrypt password" do
    @user.encrypt_password
    @user.password.should == 'e0489cd5c151d95f52ce708a6158bb8c3d05b6fc'
  end
  
  it "should authenticate user ok" do
    user_info_ok = {:username => 'user1', :password => 'admin'}
    User.authenticate(user_info_ok).should != nil
  end
    
  it "shoud not authenticate user" do
    user_info_not_ok = {:username => 'user1', :password => 'vaara'}
    User.authenticate(user_info_not_ok).should == nil 
  end
end
