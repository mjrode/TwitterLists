class List < ActiveRecord::Base
  has_many :friend_list_schedules, dependent: :destroy
  has_many :friends, through: :friend_list_schedules
  belongs_to :user
  validates :name, presence: true
  validates :name, uniqueness: true

  def on_list
    self.friend_list_schedules.where("schedule != ?", "Never on List")
  end

  def new_list?(user)
    list_names = TWITTER_CLIENT.lists(user.twitter_id).map{|list| list.name }
    unless list_names.include?(self.name)
      true
    end
  end

end
