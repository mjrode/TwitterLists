class Users::ImportLists < Less::Interaction
  expects :username

  def run
    fetch_remote_lists
  end

  private

  def remote_lists
    TWITTER_CLIENT.lists(username)
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
      user_id:  user.id)
  end

  def remote_members(remote_list)
    TWITTER_CLIENT.list_members(username, remote_list.id)    
  end

  def local_list(remote_list)
    List.find_by_remote_id(remote_list.id)
  end

  def local_friend(remote_member)
      friend = Friend.find_by_remote_id(remote_member.id)
  end

  def create_schedule(remote_list)
    # rate limit issues here
    remote_members(remote_list).each do |remote_member|
      FriendListSchedule.create(
        list_id: local_list(remote_list).id, 
        friend_id: local_friend(remote_member).id, 
        schedule: "Always on List" )
    end
  end
end
