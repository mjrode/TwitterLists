class Tweets::ShareApp < Less::Interaction
  expects :message
  expects :user

  def run
    @client = Shared::SetTwitterClient.run(user: user)
    share
    set_as_shared
  end

  private

  def set_status_as_replied
    tweet = Tweet.find(tweet_id)
    tweet.replied = true
    tweet.save
  end

  def share
    @client.update(message) if Rails.env.production?
  end

  def set_as_shared
    user.shared = true
    user.save!
  end
end
