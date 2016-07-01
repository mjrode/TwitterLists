class Replies::SendReply < Less::Interaction
  expects :message
  expects :remote_tweet_id
  expects :user
  expects :tweet_id

  def run
    @client = Shared::SetTwitterClient.run(user: user)
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
end
