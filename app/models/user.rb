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
  has_many :tweets

  def sort(params)
    tweets.where(replied: false).order("remote_tweet_created_at DESC").page(params[:page])
  end
end
