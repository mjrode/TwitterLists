class Users::ImportLists < Less::Interaction
  expects :username

  def run
    cache_lists
  end

  private

  def get_list_ids_from_twitter
    TWITTER_CLIENT.lists(username)
  end

  def cache_lists
    get_list_ids_from_twitter.each do |list|
      save_list_id(list)
      # commenting out due to rate limit issues
      # create_schedule(list)
    end
  end


  def save_list_id(list)
    user = User.find_by_username(username)
    List.create(
      name: list.name,
      remote_id:  list.id, 
      user_id:  user.id)
  end

  def create_schedule(list)
    # rate limit issues here
    binding.pry
    members = TWITTER_CLIENT.list_members(username, list.id)
    list = List.find_by_remote_id(list.id)
    members.each do |member|
      friend = Friend.find_by_remote_id(member.id)
      FriendListSchedule.create(
        list_id: list.id, 
        friend_id: friend.id, 
        schedule: "Always on List" )
    end
  end
end
