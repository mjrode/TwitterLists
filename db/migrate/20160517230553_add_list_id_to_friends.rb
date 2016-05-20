class AddListIdToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :list_id, :integer
  end
end
