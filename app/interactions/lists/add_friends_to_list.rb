class Lists::AddFriendsToList < Less::Interaction
  expects :friends_hash
  expects :list
  expects :user
  returns :id

  def run
    create_schedules
    self.id = list.id
    self
  end

  private

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