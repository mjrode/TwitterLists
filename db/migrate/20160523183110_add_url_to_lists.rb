class AddUrlToLists < ActiveRecord::Migration
  def change
    add_column :lists, :url, :string
  end
end
