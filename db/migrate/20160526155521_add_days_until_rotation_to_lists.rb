class AddDaysUntilRotationToLists < ActiveRecord::Migration
  def change
    add_column :lists, :days_until_rotation, :integer
  end
end
