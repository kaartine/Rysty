require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
 
describe User do
  before(:each) do
    @user = Factory.create(:user)
#    @user.admin = false
#    @user.salt = '1234'
#    @user.password = 'admin'
#    @user.username = 'user1'
  end
 
  it "should encrypt password when user saved" do
    @user.save!
    @user.password.should == 'e0489cd5c151d95f52ce708a6158bb8c3d05b6fc'
  end
  
  it "should authenticate user ok" do
    User.authenticate('user1', 'admin').should != nil
  end
    
  it "shoud not authenticate user" do
    User.authenticate('user1', 'vaara').should == nil 
  end
end
