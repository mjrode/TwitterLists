class Friend < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :friend_list_schedules, dependent: :destroy
  has_many :users, through: :friend_list_schedules

  def current_schedule(list)
    self.friend_list_schedules.where(list_id: list.id).first.schedule
  rescue NoMethodError
    4
  end
end
