# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string
#  name       :string
#  location   :string
#  url        :string
#  image_url  :string
#  token      :string
#  secret     :string
#  remote_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#  shared     :boolean          default(FALSE)
#  imported   :boolean          default(FALSE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
