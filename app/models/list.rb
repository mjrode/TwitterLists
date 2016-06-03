# == Schema Information
#
# Table name: lists
#
#  id                  :integer          not null, primary key
#  name                :string
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  remote_id           :integer
#  url                 :string
#  days_until_rotation :integer
#

class List < ActiveRecord::Base
  has_many :friend_list_schedules, dependent: :destroy
  has_many :friends, through: :friend_list_schedules
  belongs_to :user
  validates :name, presence: true
  validates :name, uniqueness: true

  scope :needs_rotation, -> { where("(updated_at + (days_until_rotation || ' DAY')::INTERVAL) <= CURRENT_TIMESTAMP") }

  def on_list
    self.friend_list_schedules.where("schedule != ?", "4")
  end

  def new_list?(user)
    names_of_lists = TWITTER_CLIENT.lists(user.remote_id).map(&:name)
    !names_of_lists.include?(self.name)
  end

  def always_on_list
    self.friend_list_schedules.where(schedule: "1")
  end

  def never_on_list
    self.friend_list_schedules.where(schedule: "4")
  end

  def sometimes_on_list
    self.friend_list_schedules.where(schedule: "3")
  end

  def frequently_on_list
    self.friend_list_schedules.where(schedule: "2")
  end

  def next_rotation
    updated_at + days_until_rotation.days
  end

  def needs_rotation?
    next_rotation <= Time.now
  end
end
