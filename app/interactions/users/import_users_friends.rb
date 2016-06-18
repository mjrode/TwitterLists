# Import users Twitter Friends and save them locally
# Sets FriendListSchedule for friends imported from current lists
class Users::ImportUsersFriends < Less::Interaction
  expects :user

  def run
    set_twitter_client
    delay.fetch_all_friends
    delay.fetch_all_list_members
    delay.remove_local_friends
    self
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

  def import_key
    SecureRandom.base64
  end

  def save_friend(friend)
    Friend.create(
      name: friend.name,
      username: friend.screen_name,
      user_id: user.id,
      bio: friend.description,
      remote_id: friend.id,
      avatar: friend.profile_image_uri.to_s.gsub("_normal", "")
    )
  end

  def remote_friends_usernames
    @remote_friends_usernames ||= []
  end

  def fetch_all_friends
    followers = @client.friends(user.username, count: 200)
    followers.each do |f|
      save_friend(f)
      remote_friends_usernames << f.screen_name
    end
  end

  def remove_local_friends
    Friend.all.each do |friend|
      friend.destroy unless remote_friends_usernames.include?(friend.username)
    end
  end

  def lists
    @client.lists(user.username)
  end

  def fetch_all_list_members
    lists.each do |list|
      members = @client.list_members(user.username, list.id)
      members.each do |member|
        save_friend(member)
        remote_friends_usernames << member.screen_name
      end
    end
  end
end
