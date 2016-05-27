# Import users Twitter Friends and save them locally
class Users::ImportUsersFriends < Less::Interaction
  expects :user

  def run
    set_twitter_client
    delay.fetch_all_friends
    delay.fetch_all_list_members
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
      remote_id: friend.id
    )
  end

  def fetch_all_friends
    followers = @client.friends(user.username, count: 200)
    followers.each do |f|
      save_friend(f)
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
        create_schedule(member, list)
      end
    end
  end

  def create_schedule(member, list)
    friend = Friend.find_by_username(member.screen_name)
    list = List.find_by_remote_id(list.id)
    FriendListSchedule.create(
      friend_id: friend.id,
      list_id: list.id,
      schedule: 1
    )
  end
end
