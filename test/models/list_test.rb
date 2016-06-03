# == Schema Information
#
# Table name: lists
#
#  id                  :integer          not null, primary key
#  name                :string
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  remote_id           :integer
#  url                 :string
#  days_until_rotation :integer
#

require 'test_helper'

class ListTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
