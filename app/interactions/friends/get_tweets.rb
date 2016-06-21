class Friends::GetTweets < Less::Interaction
  expects :friend
  expects :user

  def run
    set_twitter_client
    tweets = get_tweets
    save_tweets(tweets)
    @new_tweets
  end

  private

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
  end

  def get_tweets
    @client.user_timeline(
      friend.username,
      exclude_replies: true,
      trim_user: true,
      include_rts: false,
      count: 200
    )
  rescue Twitter::Error => e
    Honeybadger.notify e
    []
  end

  def save_tweets(tweets)
    @new_tweets = []
    tweets.each do |remote_tweet|
      store_tweet(remote_tweet)
    end
  end

  def store_tweet(remote_tweet)
    if !Tweet.exists?(remote_tweet_id: remote_tweet.id) && remote_tweet.media?
      html_block = Tweets::Oembed.run(remote_tweet_id: remote_tweet.id)
      local_tweet = create_local_tweet(remote_tweet, html_block)
      @new_tweets.push(local_tweet)
    end
  end

  def create_local_tweet(tweet, html_block)
    friend.tweets.create(
      remote_tweet_id: tweet.id,
      source: tweet.url,
      remote_tweet_created_at: tweet.created_at,
      html_block: html_block,
      friend_id: friend.user_id,
      user_id: user.id
    )
  end
end
