class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def change
    add_column :lists, :next_rotation_at, :datetime
  end
end
