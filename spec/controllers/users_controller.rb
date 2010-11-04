require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Admin::UsersController do
  integrate_views
  
  user = mock_model(User)
  User.stub!(:index).adn_return(user)
    
end
