class AddSinceIdToFriend < ActiveRecord::Migration
  def change
    add_column :friends, :since_id, :bigint
  end
end
