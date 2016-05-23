class AddBioToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :bio, :string
  end
end
