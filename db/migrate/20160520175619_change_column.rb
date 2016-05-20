class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :lists, :api_list_id, :bigint
  end
end
