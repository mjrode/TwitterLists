class FriendListSchedule < ActiveRecord::Base
  belongs_to :list
  belongs_to :friend

  def self.schedules
    ["Never on List", "Always on List", "Rotates on and off list"]
  end

end
