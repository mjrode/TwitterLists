class Replies::SendReply < Less::Interaction
  expects :message
  expects :remote_tweet_id
  expects :user_id
  expects :tweet_id

  def run
    set_twitter_client
    reply
    set_status_as_replied
  rescue Twitter::Error::Forbidden
    false
  else
    true
  end

  private

  def set_status_as_replied
    tweet = Tweet.find(tweet_id)
    tweet.replied = true
    tweet.save
  end

  def reply
    @client.update(message, in_reply_to_status_id: remote_tweet_id)
  end

  def set_twitter_client
    @user = User.find(user_id)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = @user.token
      config.access_token_secret = @user.secret
    end
  end
end
