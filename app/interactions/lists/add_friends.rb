class Lists::AddFriends < Less::Interaction
  include Lists::Managing

  expects :friends_hash
  expects :list
  expects :user
  expects :days_between_rotation

  returns :message
  returns :success

  def run
    set_rotation
    add_friends_to_local_list
    update_remote_list_members(list)
    email_list_updates(list) if success
    self
  end

  private

  def set_rotation
    list.update_attributes(
      days_between_rotation: days_between_rotation,
      next_rotation_at: (Time.now + days_between_rotation.days)
    )
  end

  def add_friends_to_local_list
    Lists::AddFriendsToLocalList.run(
      friends_hash: friends_hash,
      list: list,
      user: user
    )
  end
end
