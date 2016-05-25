class FriendListSchedule < ActiveRecord::Base
  belongs_to :list
  belongs_to :friend

  def self.schedules
    [["Never on List", 4],  ["Sometimes on list", 3],["Frequently on List", 2],["Always on List",1 ]]
  end

end
