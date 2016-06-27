# Import users Twitter Friends and saves them locally
# Sets FriendListSchedule for friends imported from current lists
# Deletes local copy of friend if you stopped following them
# Fetches Tweets for all friends and list members
# Imports lists and creates local copies
class Users::ImportTwitterAccountInformation < Less::Interaction
  expects :user

  def run
    set_twitter_client
    fetch_all_friends
    fetch_all_list_members
    remove_local_friends
    Lists::ImportLists.run(user: user)
    fetch_tweets
    Listmailer.user_logged_in_email(user).deliver_later if user.email.present?
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

  def fetch_all_friends
    followers = @client.friends(user.username, count: 200)
    followers.each do |f|
      save_friend(f, true)
      remote_friends_usernames << f.screen_name
    end
  end

  def fetch_all_list_members
    lists.each do |list|
      members = @client.list_members(user.username, list.id)
      members.each do |member|
        save_friend(member, true)
        remote_friends_usernames << member.screen_name
      end
    end
  end

  def import_key
    SecureRandom.base64
  end

  def save_friend(friend, following)
    Friend.create(
      name: friend.name,
      username: friend.screen_name,
      user_id: user.id,
      bio: friend.description,
      remote_id: friend.id,
      following: following,
      avatar: friend.profile_image_uri.to_s.gsub("_normal", "")
    )
  end

  def remote_friends_usernames
    @remote_friends_usernames ||= []
  end

  def remove_local_friends
    Friend.all.each do |friend|
      friend.destroy unless remote_friends_usernames.include?(friend.username)
    end
  end

  def lists
    @client.lists(user.username)
  end

  def fetch_tweets
    Friend.all.each do |friend|
      Friends::GetTweets.run(friend: friend, user: user)
      sleep 3 unless Rails.env.test?
    end
  end
end
