class RemoveListIdFromFriends < ActiveRecord::Migration
  def change
    remove_column :friends, :list_id, :integer
  end
end
