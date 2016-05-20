class Users::ImportUsersFriends < Less::Interaction
 expects :user

   def run
     delay.fetch_all_friends
     delay.fetch_all_list_members
     self
   end

   private

   def import_key
     SecureRandom.base64
   end

   def save_friend(friend)
     Friend.create(
       username: friend.screen_name,
       user_id: user.id
     )
   end

   def fetch_all_friends
     followers = TWITTER_CLIENT.friends(user.username, count: 200)
     followers.each do |f|
       save_friend(f)
     end
   end

   def lists
     TWITTER_CLIENT.lists(user.username)
   end

   def fetch_all_list_members
     lists.each do |list|
       members = TWITTER_CLIENT.list_members(user.username, list.id)
       members.each do |member|
         save_friend(member)
         create_schedule(member, list)
       end
     end
   end

   def create_schedule(member, list)
    friend = Friend.find_by_username(member.screen_name)
    list = List.find_by_api_list_id(list.id)
     FriendListSchedule.create(
      friend_id: friend.id, 
      list_id: list.id)
   end
 end
 