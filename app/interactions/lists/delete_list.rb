class Lists::DeleteList < Less::Interaction
  expects :list
  expects :user

  def run
  set_twitter_client  
  destroy_remote_list
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

  def destroy_remote_list
    @client.destroy_list(list.remote_id)
  end



end