require 'test_helper'

class Users::ImportUsersFriendsTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: "mjr_tts",  
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ', 
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF'
    )
  end

  test "adds friends to database" do
    use_cassette("importthemfriends") do 
      assert_changed -> { Friend.count } do
        Users::ImportUsersFriends.run(user: @user)
        puts Friend.count
      end
    end
  end
end
