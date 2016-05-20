class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :friend_list_schedule
      t.integer :list_id
      t.integer :friend_id
      t.string :schedule

      t.timestamps null: false
    end
  end
end
