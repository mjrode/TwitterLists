class Friend < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :friend_list_schedules, dependent: :destroy
  has_many :users, through: :friend_list_schedules
end
