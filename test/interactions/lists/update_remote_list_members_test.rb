# how to test without actually changing the members on the remote list
# think that I need to mock the @client?
require 'test_helper'
class Lists::UpdateRemoteListMembersTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF',
      remote_id: "711995065347006465"
    )
    @friends_to_add = ["kendricklamar"]
    @friends_to_remove = ["jasoncummings86"]
  end

  test "old list members get removed" do
    VCR.use_cassette("update remote lists") do
      interaction = Lists::UpdateRemoteListMembers.new(
        randomized_list_of_friends: list_of_friends,
        user_id: @user.id,
        list: lists(:first_list)
      )
      interaction.twitter_client.expects(:remove_list_members).with(
        @user.remote_id,
        lists(:first_list).remote_id,
        @friends_to_remove
      )
      interaction.twitter_client.expects(:add_list_members).with(
        lists(:first_list).remote_id,
        @friends_to_add
      )
      
      interaction.run
    end
  end


  private

  def list_of_friends
    # one = kendrick, two = sports, three = jason
    [friend_list_schedules(:two), friend_list_schedules(:one)]
  end
end
