class RemoveDaysUntilRotationFromLists < ActiveRecord::Migration
  def change
    remove_column :lists, :days_until_rotation, :integer
  end
end
