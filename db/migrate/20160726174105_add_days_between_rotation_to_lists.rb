class AddDaysBetweenRotationToLists < ActiveRecord::Migration
  def change
    add_column :lists, :days_between_rotation, :integer
  end
end
