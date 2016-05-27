class Friend < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :friend_list_schedules, dependent: :destroy
  has_many :users, through: :friend_list_schedules

  def current_schedule(list)
    self.friend_list_schedules.find_by(list_id: list.id).schedule
  rescue NoMethodError
    4
  end

  def bio_extra
    self.bio ? bio : "This user does not have a bio"
  end
end
