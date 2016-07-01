require 'test_helper'

class Users::ImportTwitterAccountInformationTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF', 
      id: 22
    )
  end

  test "adds friends to database" do
    use_cassette("user_signs_in") do
      assert_changed -> { @user.friends.count } do
        Users::ImportTwitterAccountInformation.run(user: @user)
      end
    end
  end

  test "adds friends that are only on a list to database" do
    use_cassette("user_signs_in") do
      Users::ImportTwitterAccountInformation.run(user: @user)
    end
    assert @user.friends.find_by_username("Coalboat").present?
  end

  test "It does not remove local friends that are present remotely" do
    use_cassette("user_signs_in") do
      Users::ImportTwitterAccountInformation.run(user: @user)
    end
    assert @user.friends.find_by_username("jasoncummings86").present?    
  end

  test "followers that are not your friends do not get added" do
    use_cassette("user_signs_in") do
      Users::ImportTwitterAccountInformation.run(user: @user)
    end
    assert @user.friends.find_by_username("marketmembrane").nil?
  end

  test "If you unfollow a friend on twitter they are deleted from the database" do
    assert @user.friends.find_by_username("deleteme").present?
    use_cassette("user_signs_in") do
      Users::ImportTwitterAccountInformation.run(user: @user)
    end
    assert @user.friends.find_by_username("deleteme").nil?
  end

  test "Tweets get added to database when friend logs in" do 
    use_cassette("user_signs_in") do 
      assert_changed -> { Tweet.count } do 
        Users::ImportTwitterAccountInformation.run(user: @user)
      end
    end
  end
end
