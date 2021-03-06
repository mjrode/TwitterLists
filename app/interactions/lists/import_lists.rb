# Creates local copies of remote lists when user signs in
class Lists::ImportLists < Less::Interaction
  expects :user

  def run
    @client = Shared::SetTwitterClient.run(user: user)
    fetch_remote_lists
  end

  private

  def remote_lists
    @client.lists(user.username)
  end

  def fetch_remote_lists
    remote_lists.each do |remote_list|
      save_local_list(remote_list)
      create_friend_list_schedules(remote_list)
    end
  end

  def save_local_list(remote_list)
    local_list = List.find_by(user_id: user.id, remote_id: remote_list.id)
    local_list ||= List.create!(
      name: remote_list.name,
      remote_id:  remote_list.id,
      user_id:  user.id,
      url: remote_list.url,
      mode: remote_list.mode
    )
    local_list
  end

  def remote_members(remote_list)
    @client.list_members(user.username, remote_list.id)
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
  rescue NoMethodError => e
    Honeybadger.notify(e)
  end

  def create_friend_list_schedules(remote_list)
    remote_members(remote_list).each do |remote_member|
      create_friend_list_schedule(remote_list, remote_member)
    end
  end
end
