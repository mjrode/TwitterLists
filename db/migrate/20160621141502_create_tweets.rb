class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_text
      t.integer :remote_user_id
      t.integer :remote_tweet_id
      t.string :source
      t.integer :emails_count
      t.string :html_block
      t.datetime :remote_tweet_created_at
      t.integer :direct_messages_count

      t.timestamps null: false
    end
  end
end
