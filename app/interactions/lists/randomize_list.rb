class Lists::RandomizeList < Less::Interaction
  expects :list

  def run
    #fetch_members_user_names
    generate_new_list 
  end

  private

  def fetch_members_user_names
    list = []
    friends_hash.each do |hash|
      schedule = FriendListSchedule.find_by_friend_id(hash["friend_id"])
      @list << schedule
    end
    @list
  end

  def generate_new_list
    @new_list = []
    add_always_on_list
    add_frequently_on_list
    add_sometimes_on_list
    @new_list
  end

  def add_always_on_list
    list.always_on_list.each do |schedule|
      @new_list << schedule
    end
  end

  def add_frequently_on_list 
    list_size = (list.frequently_on_list.count * 0.5).round
    random_schedules = list.frequently_on_list.sample(list_size)
    random_schedules.each do |schedule|
      @new_list << schedule
    end
  end


  def add_sometimes_on_list 
    list_size = (list.sometimes_on_list.count * 0.25).round
    random_schedules = list.sometimes_on_list.sample(list_size)
    random_schedules.each do |schedule|
      @new_list << schedule
    end
  end

end