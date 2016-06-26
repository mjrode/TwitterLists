# Creates local copies of remote lists when user signs in
class Lists::ImportLists < Less::Interaction
  expects :username

  def run
    set_twitter_client
    fetch_remote_lists
    Listmailer.user_logged_in_email(User.find_by_username(username)).deliver_now if User.find_by_username(username).email.present?
  end

  private

  def set_twitter_client
    @user = User.find_by_username(username)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = @user.token
      config.access_token_secret = @user.secret
    end
  end

  def remote_lists
    @client.lists(username)
  end

  def fetch_remote_lists
    remote_lists.each do |remote_list|
      save_local_list(remote_list)
      create_friend_list_schedules(remote_list)
    end
  end

  def save_local_list(remote_list)
    user = User.find_by_username(username)
    List.create(
      name: remote_list.name,
      remote_id:  remote_list.id,
      user_id:  user.id,
      url: remote_list.url
    )
  end

  def remote_members(remote_list)
    @client.list_members(username, remote_list.id)
  end

  def local_list(remote_list)
    List.find_by_remote_id(remote_list.id)
  end

  def local_friend(remote_member)
    Friend.find_by_remote_id(remote_member)
  end

  def create_friend_list_schedule(remote_list, remote_member)
    FriendListSchedule.create(
      list_id: local_list(remote_list).id,
      friend_id: local_friend(remote_member.id).id,
      schedule: 1
    )
  end

  def create_friend_list_schedules(remote_list)
    remote_members(remote_list).each do |remote_member|
      create_friend_list_schedule(remote_list, remote_member)
    end
  end
end
