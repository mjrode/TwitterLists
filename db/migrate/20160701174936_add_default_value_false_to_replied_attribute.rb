class AddDefaultValueFalseToRepliedAttribute < ActiveRecord::Migration
  def change
    change_column_default(:tweets, :replied, false)
  end
end
