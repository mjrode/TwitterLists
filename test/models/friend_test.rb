# == Schema Information
#
# Table name: friends
#
#  id         :integer          not null, primary key
#  username   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  bio        :string
#  remote_id  :integer
#  avatar     :string
#  following  :boolean
#

require 'test_helper'

class FriendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
