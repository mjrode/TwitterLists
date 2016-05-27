class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :friends, dependent: :destroy
  has_many :lists, dependent: :destroy

  def unassigned_friends
    unassigned_friends= []
    self.friends.each do |friend|
      friend.friend_list_schedules.where(schedule: 4).each do |schedule|
        unassigned_friend = Friend.find(schedule.friend_id)
        unassigned_friends << unassigned_friend
      end
    end
    unassigned_friends
  end
end
