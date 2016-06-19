class Lists::AddFriendsToMultipleLists < Less::Interaction
  expects :friends_hash
  expects :user
  def run
    assign_friends
  end

  private

  def format_hashes
    x = friends_hash.group_by { |f| f["list_id"] }
    x.delete_if { |k, v| k == "" || v == "" }
    x.each { |_name, list| list.map { |friend| friend.delete("list_id") } }
    x
  end

  def assign_friends
    formatted_hashes = format_hashes
    formatted_hashes.each do |hash|
      Lists::AddFriends.run(add_friends_params(hash))
    end
  end

  def add_friends_params(hash)
    {
      friends_hash: hash.last,
      list: List.find(hash.first),
      user: user
    }
  end
end
