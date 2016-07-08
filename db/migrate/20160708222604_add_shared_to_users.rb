class AddSharedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shared, :boolean, default: false
  end
end
