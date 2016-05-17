TWITTER_CLIENT = Twitter::REST::Client.new do |config|
  config.consumer_key = ENV['twitter_consumer_key']
  config.consumer_secret = ENV['twitter_secret_key']
end

