class AddDefaultValueToRepliedAttribute < ActiveRecord::Migration
  def change
    change_column_default(:tweets, :replied, true)
  end
end
