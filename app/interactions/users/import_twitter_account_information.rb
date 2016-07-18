# Import users Twitter Friends and saves them locally
# Sets FriendListSchedule for friends imported from current lists
# Deletes local copy of friend if you stopped following them
# Fetches Tweets for all friends and list members
# Imports lists and creates local copies
class Users::ImportTwitterAccountInformation < Less::Interaction
  expects :user

  def run
    @client = Shared::SetTwitterClient.run(user: user)
    delay.fetch_twitter_info
    LoggedInMailer.user_logged_in_email(user).deliver_later if user.email.present?
    self
  end

  private

  def fetch_twitter_info
    fetch_all_friends_and_tweets # refactored this so I can have a more accurate progress bar
    fetch_all_list_members
    remove_local_friends
    Lists::ImportLists.run(user: user)
  end

  def fetch_all_friends_and_tweets
    followers = @client.friends(user.username, count: 200)
    followers.each do |f|
      friend = save_friend(f, true)
      remote_friends_usernames << f.screen_name
      fetch_tweets(friend)
    end
  end

  def fetch_all_list_members
    lists.each do |list|
      members = @client.list_members(user.username, list.id)
      members.each do |member|
        friend = save_friend(member, true)
        remote_friends_usernames << member.screen_name
        fetch_tweets(friend)
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
  # binding.pry if ActiveRecord::RecordNotSaved
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

  def fetch_tweets(friend)
    Friends::GetTweets.run(friend: friend, user: user)
    sleep 3 unless Rails.env.test?
  end
end
