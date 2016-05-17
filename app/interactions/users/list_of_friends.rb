class Users::ListOfFriends < Less::Interaction
 expects :user

   def run
     delay.fetch_all_friends
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

   def fetch_all_followers
     followers = TWITTER_CLIENT.followers(user.username, count: 200)
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
       end
     end
   end

   def fetch_all_friends
     fetch_all_followers
     fetch_all_list_members
   end
 end
 