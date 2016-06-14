class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :author
      t.string :content
      t.string :image

      t.timestamps null: false
    end
  end
end
