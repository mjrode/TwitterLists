# == Schema Information
#
# Table name: tweets
#
#  id                      :integer          not null, primary key
#  tweet_text              :string
#  user_id                 :integer
#  remote_tweet_id         :integer
#  source                  :string
#  emails_count            :integer
#  html_block              :string
#  remote_tweet_created_at :datetime
#  direct_messages_count   :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  friend_id               :integer
#  replied                 :boolean          default(FALSE)
#  viewed                  :boolean          default(FALSE)
#

class Tweet < ActiveRecord::Base
  belongs_to :friend, touch: true
  belongs_to :user
  paginates_per 25

  def self.new_sorted(params)
    where(replied: false, viewed: false).order("remote_tweet_created_at DESC").page(params[:page])
  end

  def self.viewed_sorted(params)
    where(replied: false, viewed: true).order("remote_tweet_created_at DESC").page(params[:page])
  end

  def self.loaded?(current_user)
    current_user.tweets.count > 0 ? true : false
  end

  def self.viewed_all?(user)
    user.tweets.where(viewed: false).count < 2
  end
end
