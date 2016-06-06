require 'test_helper'
class Lists::AddFriendsToLocalListTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF',
      remote_id: "711995065347006465"
    )

    @list = List.create(
      id: 122,
      name: "Jake",
      user_id: '25',
      created_at: 'Mon, 06 Jun 2016 22:10:44 UTC +00:00',
      updated_at: 'Mon, 06 Jun 2016 22:10:46 UTC +00:00',
      remote_id: '739942637654921216',
      url: nil,
      days_until_rotation: 3
    )
    @friends_hash = [
      { "schedule" => "3", "friend_id" => "1619" },
      { "schedule" => "3", "friend_id" => "1331" }
    ]
  end

  test "friend list schedules get created for twitter friends" do
    use_cassette("create_schedules") do
      assert_changed -> { FriendListSchedule.count } do
        Lists::AddFriendsToLocalList.run(
          friends_hash: @friends_hash,
          list: @list,
          user: @user
        )
      end
    end
  end

  test "friend list schedules get updated for twitter friends" do
    use_cassette("create_schedules") do
      Lists::AddFriendsToLocalList.run(
        friends_hash: @friends_hash,
        list: lists(:first_list),
        user: @user
      )
      fls = FriendListSchedule.last
      assert fls.schedule = "3"
    end
  end
end
