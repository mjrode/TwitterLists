class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :location
      t.string :url
      t.string :image_url
      t.string :token
      t.string :secret
      t.bigint :twitter_id

      t.timestamps null: false
    end
  end
end
