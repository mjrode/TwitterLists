class AddTwitteridToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :twitter_id, :bigint
  end
end
