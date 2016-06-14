class AddRemoteIdToBlog < ActiveRecord::Migration
  def change
    add_column :blog_posts, :remote_id, :string
  end
end
