
require 'test_helper'

class Users::UserAuthenticationFromOauthTest < ActiveSupport::TestCase
  test 'user gets created' do
    assert_difference 'User.count' do
      Users::UserAuthenticationFromOauth.run(auth_hash: omniauth_hash)
    end
  end

  test 'user does not get created twice' do
    Users::UserAuthenticationFromOauth.run(auth_hash: omniauth_hash)
    assert_no_difference 'User.count' do 
      Users::UserAuthenticationFromOauth.run(auth_hash: omniauth_hash)  
    end
  end

  test "User attributes get set" do
    Users::UserAuthenticationFromOauth.run(auth_hash: omniauth_hash)
    assert User.last.username = "mjr_tts"
    assert User.last.name = "test less"
  end

  private

  def omniauth_hash
    OmniAuth::AuthHash.new(
      "provider" => "twitter",
      "uid" => "711995065347006465",
      "info" => 
      {"nickname" => "mjr_tts",
       "name" => "test less",
       "email" => nil,
       "location" => "",
       "image" => "http://abs.twimg.com/sticky/default_profile_images/default_profile_3_normal.png",
       "description" => "",
       "urls" => { "Website" => nil, "Twitter" => "https://twitter.com/mjr_tts" }},
      "credentials" =>
      {"token" => "711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ",
       "secret" => "Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF" }
    )
  end
end
