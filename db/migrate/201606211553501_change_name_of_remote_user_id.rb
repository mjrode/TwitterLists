class ChangeNameOfRemoteUserId < ActiveRecord::Migration
  def change
    rename_column :tweets, :remote_user_id, :user_id
  end
end
