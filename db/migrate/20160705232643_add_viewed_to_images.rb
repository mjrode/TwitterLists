class AddViewedToImages < ActiveRecord::Migration
  def change
    add_column :tweets, :viewed, :boolean, default: false
  end
end
