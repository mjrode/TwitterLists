require 'test_helper'
class Lists::CreateListTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF',
      remote_id: "711995065347006465"
    )
    use_cassette("import_friends_and_lists") do
      Users::UserAuthenticationFromOauth.run(auth_hash: omniauth_hash)
      Users::ImportUsersFriends.run(user: @user)
      Lists::ImportLists.run(username: @user.username)
    end
    @local_list = List.last
    @days_until_rotation = 3
  end

  test "able to create unique list" do
    local_list = List.new(name: "pizza list")
    use_cassette("create_list") do
      assert_changed -> { List.count } do
        Lists::CreateList.run(
          local_list: local_list,
          days_until_rotation: @days_until_rotation,
          user: @user
        )
      end
    end
  end

  private

  def omniauth_hash
    OmniAuth::AuthHash.new(
      "provider" => "twitter",
      "uid" => "711995065347006465",
      "info" =>
    {  "nickname" => "mjr_tts",
       "name" => "test less",
       "email" => nil,
       "location" => "",
       "image" => "http://abs.twimg.com/sticky/default_profile_images/default_profile_3_normal.png",
       "description" => "",
       "urls" => { "Website" => nil, "Twitter" => "https://twitter.com/mjr_tts" } },
      "credentials" =>
    { "token" => "711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ",
      "secret" => "Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF" }
    )
  end
end
