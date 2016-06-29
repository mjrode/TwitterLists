require 'test_helper'

class Lists::ImportListsTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF'
    )
    use_cassette("import_friends_setup") do
      Users::ImportTwitterAccountInformation.run(user: @user)
    end
  end

  test "local lists get saved" do
    use_cassette("import_lists") do
      User.find_by_username("mjrode").destroy
      assert_changed -> { List.count } do
        Lists::ImportLists.run(user: @user)
      end
    end
  end

  test "friend list schedule gets created" do
    use_cassette("import_lists") do
      assert_changed -> { FriendListSchedule.count } do
        Lists::ImportLists.run(user: @user)
      end
    end
  end
end
