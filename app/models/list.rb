class List < ActiveRecord::Base
  has_many :friend_list_schedules, dependent: :destroy
  has_many :friends, through: :friend_list_schedules
  validates :api_list_id, uniqueness: true
  validates :name, presence: true
  validates :name, uniqueness: true


end
