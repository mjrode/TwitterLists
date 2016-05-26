# removed unless hash[:friend_id] == nil

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

  def update_schedules
    friends_hash.each do |hash|
      schedule = list.friend_list_schedules.find_by_friend_id(hash[:friend_id])
      schedule.update_attributes(
        list_id: list.id, 
        friend_id: hash[:friend_id],
        schedule: hash[:schedule]
        )
    end
  end

  def create_schedules
    friends_hash.each do |hash|
      FriendListSchedule.create(
        list_id: list.id, 
        friend_id: hash[:friend_id],
        schedule: hash[:schedule]
      )
    end
  end

end