require 'test_helper'

class UserFlowsTest < ActionController::IntegrationTest
    fixtures :users

    def test_login_and_browse_site
    # User avs logs in

    avs = login(:admin)

    # User guest logs in
    guest = login(:guest)

    # Both are now available in different sessions

    assert_equal 'Welcome avs!', avs.flash[:notice]
    assert_equal 'Welcome guest!', guest.flash[:notice]

    # User avs can browse site
    avs.browses_site

    # User guest can browse site aswell
    guest.browses_site

    # Continue with other assertions
    end

  private

    module CustomDsl
      def browses_site
        get "/products/all"
        assert_response :success
        assert assigns(:products)
      end
    end

    def login(user)
      open_session do |sess|
        sess.extend(CustomDsl)
        u = users(user)
        sess.https!
        sess.post "/login", :username => u.username, :password => u.password
        assert_equal '/', path
        sess.https!(false)
      end
    end
end
