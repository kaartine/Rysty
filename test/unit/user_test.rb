require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  def test_creation
    user = User.new
    assert !user.save, "Tryin to save empty user"
  end
  
 
end
