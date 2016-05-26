class FriendListSchedule < ActiveRecord::Base
  belongs_to :list
  belongs_to :friend
  validates_with ::MyValidator

  def self.schedules
    [["Never on List", 4],  ["Sometimes on list", 3],["Frequently on List", 2],["Always on List",1 ]]
  end


  def unique_schedule?
   if FriendListSchedule.where(list_id: self.list_id, friend_id: self.friend_id).count > 0 
      false
    else 
      true
    end
  end

end


