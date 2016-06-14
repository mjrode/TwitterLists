class AddAvatarToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :avatar, :string
  end
end
