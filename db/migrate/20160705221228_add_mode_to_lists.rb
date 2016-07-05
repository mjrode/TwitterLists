class AddModeToLists < ActiveRecord::Migration
  def change
    add_column :lists, :mode, :string
  end
end
