class AddApiListIdToLists < ActiveRecord::Migration
  def change
    add_column :lists, :api_list_id, :integer
  end
end
