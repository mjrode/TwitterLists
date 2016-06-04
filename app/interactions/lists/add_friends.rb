class Lists::AddFriends < Less::Interaction
  expects :friends_hash
  expects :list
  expects :user

  def run
    add_friends_to_local_list
    update_remote_list_members
  end

  private

  def add_friends_to_local_list
    Lists::AddFriendsToLocalList.run(
      friends_hash: friends_hash,
      list: list,
      user: user
    )
  end

  def update_remote_list_members
    Lists::UpdateRemoteListMembers.run(
      randomized_list_of_friends: randomized_list,
      list: list,
      user_id: user.id
    )
  end

  def randomized_list
    @randomized_list ||= Lists::RandomizeList.run(list: list)
  end
end
