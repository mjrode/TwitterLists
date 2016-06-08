class Lists::AddFriendsToDifferentLists < Less::Interaction
  expects :friends_hash
  expects :user
  def run
    assign_friends
  end

  private

  def parse_info
    x = friends_hash.group_by { |f| f["list_name"] }
    x.delete_if { |k, _v| k == "" }
    x.each { |_name, list| list.map { |friend| friend.delete("list_name") } }
    x
  end

  def assign_friends
    parse_info.each do |hash|
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
