class ChangeRemoteTweetIdToTweets < ActiveRecord::Migration
  def change
    change_column :tweets, :remote_tweet_id, :bigint
  end
end
