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
    end
  end


  def save_list_id(list)
    user = User.find_by_username(username)
    List.create(
      name: list.name,
      api_list_id:  list.id, 
      user_id:  user.id)
  end



end