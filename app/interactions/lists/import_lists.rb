class Lists::ImportLists < Less::Interaction
  expects :username

  def run
    set_twitter_client
    fetch_remote_lists
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
      create_schedule(remote_list)
    end
  end

  def save_local_list(remote_list)
    user = User.find_by_username(username)
    List.create(
      name: remote_list.name,
      remote_id:  remote_list.id,
      user_id:  user.id
    )
  end

  def remote_members(remote_list)
    @client.list_members(username, remote_list.id)
  end

  def local_list(remote_list)
    List.find_by_remote_id(remote_list.id)
  end

  def local_friend(remote_member)
    Friend.find_by_remote_id(remote_member.id)
  end

  def reset_schedules(remote_list)
    list = List.find_by_remote_id(remote_list.id)
    list.friend_list_schedules.destroy_all
  end

  def create_schedule(remote_list)
    reset_schedules(remote_list)
    remote_members(remote_list).each do |remote_member|
      unless local_friend(remote_member).try(:id).nil?
        FriendListSchedule.create(
          list_id: local_list(remote_list).id,
          friend_id: local_friend(remote_member).id,
          schedule: 1
        )
      end
    end
  end
end
