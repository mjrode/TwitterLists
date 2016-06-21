# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string
#  name       :string
#  location   :string
#  url        :string
#  image_url  :string
#  token      :string
#  secret     :string
#  remote_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#

class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :friends, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :friend_list_schedules, through: :lists

  def unassigned_friends
    unassigned_friends = []
    self.friends.find_each do |friend|
      unassigned_friends << friends if friend.friend_list_schedules.empty?
      friend.friend_list_schedules.where(schedule: 4).find_each do |schedule|
        unassigned_friend = Friend.find(schedule.friend_id)
        unassigned_friends << unassigned_friend
      end
    end
    unassigned_friends
  end

  # def unassigned_friends
  #   unassigned_friends = []
  #   self.friends.each do |friend|
  #     friend.friend_list_schedules.where(schedule: 4) do |schedule|
  #       unassigned_friend = Friend.find(schedule.friend_id)
  #       unassigned_friends << unassigned_friend
  #     end
  #   end
  #   unassigned_friends
  # end
end
