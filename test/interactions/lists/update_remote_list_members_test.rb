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
    set_twitter_client
  end

  test "old list members get removed" do
    use_cassette("update remote lists") do
      Lists::UpdateRemoteListMembers.run(
        randomized_list_of_friends: randomized_list_of_friends,
        user_id: @user.id,
        list: lists(:first_list)
      )
      members = @client.list_members(lists(:first_list).remote_id)
    end
  end

  private

  def randomized_list_of_friends
    @fls = []
    @fls.push(friend_list_schedules(:two), friend_list_schedules(:three))
    @fls
  end

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = @user.token
      config.access_token_secret = @user.secret
    end
  end
end
