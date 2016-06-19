require 'test_helper'
class Lists::AddFriendsToMultipleListsTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF',
      remote_id: "711995065347006465",
      email: "Michaelrode44@gmail.com"
    )
    @friend_list_schedules = [
      { "list_id" => "", "schedule" => "4", "friend_id" => "120" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "121" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "122" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "123" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "124" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "125" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "126" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "127" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "128" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "129" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "130" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "131" },
      { "list_id" => "", "schedule" => "4", "friend_id" => "132" },
      { "list_id" => "112996373", "schedule" => "1", "friend_id" => "133448" },
      { "list_id" => "112996376", "schedule" => "2", "friend_id" => "133456" }
    ]
  end

  test "friends get added to multiple lists" do
    user_log_in
    assert FriendListSchedule.where(list_id: "112996373", friend_id: "133448").count == 0
    assert FriendListSchedule.where(list_id: "112996374", friend_id: "133456").count == 0
    use_cassette("add friends to multiple lists") do
      AddFriendsToMultipleLists.run(friends_hash: @friend_list_schedules, user: @user)
    end
    assert FriendListSchedule.where(list_id: "112996373", friend_id: "133448").count != 0
    assert FriendListSchedule.where(list_id: "112996374", friend_id: "133456").count == 0
  end

  private

  def user_log_in
    use_cassette("import remote friends and lists") do
      Users::ImportUsersFriends.run(user: @user)
      Lists::ImportLists.run(username: @user.username)
    end
  end
end
