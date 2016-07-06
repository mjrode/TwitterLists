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

require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
