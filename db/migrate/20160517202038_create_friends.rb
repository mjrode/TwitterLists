class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :username
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
