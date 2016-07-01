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
  # rubocop:disable all
  scope :needs_rotation, -> { where("(updated_at + (days_until_rotation || ' DAY')::INTERVAL) <= CURRENT_TIMESTAMP") }
  # rubocop:enable all

  def ordered
    self.friends.reorder('friend_list_schedules.schedule')
  end

  def name_for_select
    name.titleize
  end

  def new_list?(user)
    names_of_lists = TWITTER_CLIENT.lists(user.remote_id).map(&:name)
    !names_of_lists.include?(self.name)
  end

  def last_friend
    "The last friend you added to this list was: #{self.friends.last.name}" if self.friends.count > 0
    "There are no friends on this list."
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

  def on_list
    self.friend_list_schedules.where("schedule != ?", "4")
  end

  def frequently_on_list
    self.friend_list_schedules.where(schedule: "2")
  end

  def next_rotation
    updated_at + days_until_rotation.days
  end

  def needs_rotation?
    next_rotation <= Time.zone.now
  end

  def group_by_schedule
    self.friend_list_schedules.reorder("schedule").includes(:friend).map(&:friend)
  end

  def avatar_sample
    if self.friends.count < 4
      self.friends.select(:avatar).sample
    else
      self.friends.pluck(:avatar).last(4)
    end
  end
end
