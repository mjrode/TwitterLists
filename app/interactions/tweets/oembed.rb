class Tweets::Oembed < Less::Interaction
  require 'faraday'
  expects :remote_tweet_id

  def run
    response
  end

  private

  def response
    url = "https://api.twitter.com/1.1/statuses/oembed.json?id=#{remote_tweet_id}"
    response = Faraday.get(url).body
    r = JSON.parse(response)
    if r["errors"]
      ::Honeybadger.notify "Twitter error: " => r
    else
      r["html"]
    end
  end
end
