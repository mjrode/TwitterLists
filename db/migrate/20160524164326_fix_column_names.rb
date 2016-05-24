class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :lists, :api_list_id, :remote_id
    rename_column :friends, :twitter_id, :remote_id
    rename_column :users, :twitter_id, :remote_id
  end
end
