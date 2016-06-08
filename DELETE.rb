
friends = [{"friend_id"=>"1637", "list_name"=>"Sports", "schedule"=>"2"},
   {"friend_id"=>"1638", "list_name"=>"Sports", "schedule"=>"2"},
   {"friend_id"=>"1639", "list_name"=>"Code", "schedule"=>"3"},
   {"friend_id"=>"1640", "list_name"=>"Sports", "schedule"=>"3"},
   {"friend_id"=>"1641", "list_name"=>"Code", "schedule"=>"4"},
   {"friend_id"=>"1642", "list_name"=>"Code", "schedule"=>"4"},
   {"friend_id"=>"1643", "list_name"=>"Code", "schedule"=>"4"}]

x = friends.group_by { |f| f["list_name"] }
x.each { |name, list| list.map { |friend| friend.delete("list_name") } }
puts x
# {"Sports" => [{"schedule"=>"3", "friend_id"=>"1633"},
#  {"schedule"=>"2", "friend_id"=>"1634"},
#  {"schedule"=>"4", "friend_id"=>"1635"},
#  {"schedule"=>"1", "friend_id"=>"1636"},
#  {"schedule"=>"4", "friend_id"=>"1637"},
#  {"schedule"=>"1", "friend_id"=>"1638"},
#  {"schedule"=>"4", "friend_id"=>"1639"},
#  {"schedule"=>"4", "friend_id"=>"1640"},
#  {"schedule"=>"4", "friend_id"=>"1641"},
#  {"schedule"=>"4", "friend_id"=>"1642"},
#  {"schedule"=>"4", "friend_id"=>"1643"}]}   
#  list_names = friends.map { |f| f["list_name"] }.uniq

# list_names.each do |list_name|
#   friends.each do |friend|
#     instance_variable_set(list_name) = []
#     list_name.push(friend["friend_id"], friend["schedule"]) if friend["list_name"] == list_name
#   end
# end

# puts code
