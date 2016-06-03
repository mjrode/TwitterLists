# == Schema Information
#
# Table name: friend_list_schedules
#
#  id         :integer          not null, primary key
#  list_id    :integer
#  friend_id  :integer
#  schedule   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FriendListSchedule < ActiveRecord::Base
  belongs_to :list
  belongs_to :friend
  validates_uniqueness_of :id, scope: [:friend_id, :list_id]

  def self.schedules
    [["Never on List", 4], ["Sometimes on list", 3], ["Frequently on List", 2], ["Always on List", 1]]
  end

  def unique_schedule?
    FriendListSchedule.where(list_id: self.list_id, friend_id: self.friend_id).any?
  end
end
