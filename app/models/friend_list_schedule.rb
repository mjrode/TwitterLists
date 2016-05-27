class FriendListSchedule < ActiveRecord::Base
  belongs_to :list
  belongs_to :friend

  def self.schedules
    [["Never on List", 4], ["Sometimes on list", 3], ["Frequently on List", 2], ["Always on List", 1]]
  end

  def unique_schedule?
    FriendListSchedule.where(list_id: self.list_id, friend_id: self.friend_id).any?
  end
end
