class Lists::UpdateRemoteListMembers < Less::Interaction
  expects :list
  expects :randomized_list_of_friends
  expects :user_id

  def run
    update_friends
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
  end

  private

  def user
    @user ||= User.find(user_id)
  end

  def update_friends
    remove_members
    add_members
  end

  def current_list_of_friends
    current_list_of_friends = []
    unless list.new_list?(user)
      remote_members = twitter_client.list_members(list.remote_id)
      remote_members.each do |member|
        current_list_of_friends << member.screen_name
      end
    end
    current_list_of_friends
  end

  def remove_members
    friends_to_remove = current_list_of_friends - list_of_randomized_friends
    twitter_client.remove_list_members(user.remote_id, list.remote_id, friends_to_remove)
  end

  def add_members
    friends_to_add = list_of_randomized_friends - current_list_of_friends
    twitter_client.add_list_members(list.remote_id, friends_to_add)
  end

  def list_of_randomized_friends
    friends = []
    randomized_list_of_friends.each do |schedule|
      friends << schedule.friend.username
    end
    friends
  end
end
