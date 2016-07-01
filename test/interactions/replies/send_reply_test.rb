require 'test_helper'

class Replies::SendReplyTest < ActiveSupport::TestCase
  def setup
    @message = "This is a test message"
    @user = users(:mike)
    @tweet_id = tweets(:tweet).id
    @tweet = tweets(:tweet)
    @remote_tweet_id = tweets(:tweet).remote_tweet_id
  end

  test "tweet status gets set to replied" do 
    refute Tweet.find(@tweet_id).replied
    use_cassette("send_reply_to_tweet") do 
      Replies::SendReply.run(
        message: @message,
        remote_tweet_id: @remote_tweet_id,
        user: @user,
        tweet_id: @tweet_id
      )
    end
    assert Tweet.find(@tweet_id).replied == true
  end
end
