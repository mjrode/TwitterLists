# == Schema Information
#
# Table name: friend_list_schedules
#
#  id         :integer          not null, primary key
#  list_id    :integer
#  friend_id  :integer
#  schedule   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FriendListScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
