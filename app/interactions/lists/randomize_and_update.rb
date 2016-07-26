# class Lists::RandomizeAndUpdate < Less::Interaction
#   expects :user

#   def run
#     randomize_and_update_lists
#   end

#   private

#   def lists_to_update
#     user.lists.map do |list|
#       unless list.next_rotation_at != nil
#         puts list.id  if list.next_rotation_at < Time.now
#       end
#     end
#   end

#   def randomize_and_update_lists
#     # lists_to_update.each do |list_id|
#     #   randomized_list = Lists::RandomizeList.run(list: List.find(list_id)
        
#     #   Lists::UpdateRemoteListMembers.run(
#     #         randomized_list_of_friends: randomized_list,
#     #         list: List.find(list_id),
#     #         user_id: user.id
#     #       )
#     end  
#   end



# end