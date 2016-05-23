class Lists::AddFriendsToList < Less::Interaction
  expects :friend_ids
  expects :list
  expects :user

  def run
    create_schedules
    binding.pry 
  end

  private

  def create_schedules
    friend_ids.each do |id|
      user.friend_list_schedule.create(
        list_id: list.id, 
        friend_id: id)
    end
  end

end