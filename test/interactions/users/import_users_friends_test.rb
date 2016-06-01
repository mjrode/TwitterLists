require 'test_helper'

class Users::ImportUsersFriendsTest < ActiveSupport::TestCase
  def setup
    @user = users(:mike)
    Lists::ImportLists.run(username: @user.username)
  end

  test "adds friends to database" do
    use_cassette("import_friends") do 
      assert_changed -> { Friend.count } do 
        Users::ImportUsersFriends.run(user: @user)
      end
    end
  end
end
