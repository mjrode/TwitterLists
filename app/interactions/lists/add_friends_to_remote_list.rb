class Lists::AddFriendToRemoteList < Less::Interaction
  expects :list  
  expects :user_id
  
  def run
    set_twitter_client
    add_friends
    # set_url
  end

  private 

  # def set_url
  #   @client.list(user_id, @list.remote_id)
  # end

  def add_friends
    @client.add_list_members(list.remote_id, list_of_friends)
  end

  def list_of_friends
    friends = []
    list.on_list.each do |schedule|
      friends << schedule.friend.username
    end
    friends
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