require 'test_helper'
class Lists::UpdateLocalListsTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF',
      remote_id: "711995065347006465"
    )
  end

  test "remote lists get recreated locally" do
    use_cassette("update local lists") do
      assert List.find_by_name("Heroku").nil?
      Users::ImportUsersFriends.run(user: @user)
      Lists::UpdateLocalLists.run(username: @user.username)
      assert List.find_by_name("heroku").present?
    end
  end

  test "lists that are not present remotly get removed locally" do
    assert List.find_by_name("random").present?
    use_cassette("update local lists") do
      Users::ImportUsersFriends.run(user: @user)
      Lists::UpdateLocalLists.run(username: @user.username)
      assert List.find_by_name("random").nil?
    end
  end

  test "lists that are present remotely do not get removed locally" do
    assert List.find_by_name("Tech").present?
    use_cassette("update local lists") do
      Users::ImportUsersFriends.run(user: @user)
      Lists::UpdateLocalLists.run(username: @user.username)
      assert List.find_by_name("Tech").present?
    end
  end

  test "Removing a member from a list remotely will remove them locally" do
    friend_list_schedule_id = friend_list_schedules(:local).id
    assert FriendListSchedule.find(friend_list_schedule_id).present?
    use_cassette("update local lists") do
      Users::ImportUsersFriends.run(user: @user)
      Lists::UpdateLocalLists.run(username: @user.username)
    end
    assert FriendListSchedule.find_by_id(friend_list_schedule_id).nil?
  end

end
