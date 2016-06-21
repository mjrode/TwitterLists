class AddFriendIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :friend_id, :integer
  end
end
