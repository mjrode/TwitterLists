class Lists::AddFriendsToLocalList < Less::Interaction
  expects :friends_hash
  expects :list
  expects :user
  returns :id
  returns :message
  returns :success

  def run
    create_or_update_schedules
    self.id = list.id
    self
  end

  private

  def create_or_update_schedules
    if list.friends.count > 0
      update_schedules
    else
      create_schedules
    end
  end

  def create_schedules
    friends_hash.each do |friend_hash|
      FriendListSchedule.create(
        list_id: list.id,
        friend_id: friend_hash[:friend_id],
        schedule: friend_hash["schedule"]
      )
    end
  end

  def update_schedules
    friends_hash.each do |friend_hash|
      schedule = list.friend_list_schedules.find_or_create_by(friend_id: friend_hash[:friend_id])
      schedule.update_attributes(schedule: friend_hash["schedule"])
    end
  end

end
