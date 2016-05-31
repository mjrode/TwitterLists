require 'test_helper'

class Users::ImportUsersFriendsTest < ActiveSupport::TestCase
  def setup
    @user = users(:mike)
  end

  test "adds friends to database" do
    assert_difference "Friend.count" do 
      Users::ImportUsersFriends.run(user: @user)
    end
  end
end