class Lists::AddFriends < Less::Interaction
  expects :friends_hash
  expects :list
  expects :user
  returns :message
  returns :success

  def run
    add_friends_to_local_list
    update_remote_list_members
    self
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
    result = Lists::UpdateRemoteListMembers.run(
      randomized_list_of_friends: randomized_list,
      list: list,
      user_id: user.id
    )
    set_success_and_message(result)
  end

  def randomized_list
    @randomized_list ||= Lists::RandomizeList.run(list: list)
  end

  def set_success_and_message(result)
    if result
      self.success = true
      self.message = "Your list #{list.name.capitalize} has been updated"
    else
      self.success = false
      list.destroy
      self.message = "That list is no longer available and has been removed"
    end
  end
end
