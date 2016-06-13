# require 'test_helper'
# class Lists::AddFriendsToMultipleListsTest < ActiveSupport::TestCase
#   def setup
#     @user = User.create(
#       username: "mjr_tts",
#       token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
#       secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF',
#       remote_id: "711995065347006465", 
#       email: "Michaelrode44@gmail.com"
#     )
#     @hash = {
#       'friends' =>
#       [
#         { "friend_id" => "1619", "list_name" => "123", "schedule" => "3" },
#         { "friend_id" => "1334", "list_name" => "123", "schedule" => "2" },
#         { "friend_id" => "1331", "list_name" => "1234", "schedule" => "3" },
#         { "friend_id" => "1637", "list_name" => "", "schedule" => "4" },
#         { "friend_id" => "1638", "list_name" => "", "schedule" => "4" },
#         { "friend_id" => "1639", "list_name" => "", "schedule" => "4" },
#         { "friend_id" => "1640", "list_name" => "", "schedule" => "4" },
#         { "friend_id" => "1641", "list_name" => "", "schedule" => "4" },
#         { "friend_id" => "1642", "list_name" => "", "schedule" => "4" },
#         { "friend_id" => "1643", "list_name" => "", "schedule" => "4" }
#       ]
#     }
#   end

#   test "friends get added to multiple lists" do 
#     use_cassette("add friends to multiple lists") do 
#       AddFriendsToMultipleLists.run(friends_hash: @hash["friends"], user: @user)
#       binding.pry
#     end
#   end
# end
