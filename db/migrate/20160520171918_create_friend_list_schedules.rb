class CreateFriendListSchedules < ActiveRecord::Migration
  def change
    create_table :friend_list_schedules do |t|
      t.integer :list_id
      t.integer :friend_id
      t.string :schedule

      t.timestamps null: false
    end
  end
end
