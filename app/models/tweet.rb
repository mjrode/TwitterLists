# == Schema Information
#
# Table name: tweets
#
#  id                      :integer          not null, primary key
#  tweet_text              :string
#  remote_user_id          :integer
#  remote_tweet_id         :integer
#  source                  :string
#  emails_count            :integer
#  html_block              :string
#  remote_tweet_created_at :datetime
#  direct_messages_count   :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  friend_id               :integer
#

class Tweet < ActiveRecord::Base
  belongs_to :friend, touch: true
  belongs_to :user
  has_many :emails, dependent: :destroy
  has_many :direct_messages, dependent: :destroy
  paginates_per 25
end
