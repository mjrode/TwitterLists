class AddRepliedToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :replied, :boolean
  end
end
