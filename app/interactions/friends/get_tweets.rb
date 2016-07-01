class Friends::GetTweets < Less::Interaction
  expects :friend
  expects :user

  def run
    @client = Shared::SetTwitterClient.run(user: user)
    tweets = get_tweets
    save_tweets(tweets)
    @new_tweets
  end

  private

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

  def new_tweets
    @new_tweets ||= []
  end

  def save_tweets(tweets)
    tweets.each do |remote_tweet|
      store_tweet(remote_tweet)
    end
  end

  def store_tweet(remote_tweet)
    if !Tweet.exists?(remote_tweet_id: remote_tweet.id) && remote_tweet.media?
      html_block = Tweets::Oembed.run(remote_tweet_id: remote_tweet.id)
      local_tweet = create_local_tweet(remote_tweet, html_block)
      new_tweets.push(local_tweet)
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
