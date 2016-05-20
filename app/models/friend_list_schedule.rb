class FriendListSchedule < ActiveRecord::Base
  belongs_to :list
  belongs_to :friend
end
