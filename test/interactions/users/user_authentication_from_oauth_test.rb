require 'test_helper'

class Users::UserAuthenticationFromOauthTest < ActiveSupport::TestCase
  test 'it gets called' do
    Users::UserAuthenticationFromOauth.run
    pass
  end
end
