require 'test_helper'
class Lists::UpdateLocalListsTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF',
      remote_id: "711995065347006465"
    )
  end

  test "remote lists get recreated locally" do
    use_cassette("update local lists") do
      assert List.count == 2
      Users::ImportUsersFriends.run(user: @user)
      Lists::UpdateLocalLists.run(username: @user.username)
      assert List.count == 4
    end
  end

  test "lists that are not present remotly get removed locally" do
    assert List.find_by_name("random").present?
    use_cassette("update local lists") do
      Users::ImportUsersFriends.run(user: @user)
      Lists::UpdateLocalLists.run(username: @user.username)
      assert List.find_by_name("random") == nil
    end
  end
end
