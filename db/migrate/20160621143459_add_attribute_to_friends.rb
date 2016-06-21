class AddAttributeToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :following, :boolean
  end
end
