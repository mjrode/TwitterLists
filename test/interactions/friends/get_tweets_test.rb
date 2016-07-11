require 'test_helper'

class Friends::GetTweetsTest < ActiveSupport::TestCase

  def setup
    @user = User.new(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF', 
      imported: false
    )
    @friend = friends(:michael)
  end

  test 'creates tweets and ensure we get the HTML block' do
    use_cassette("user_signs_in") do 
      assert_changed -> { @friend.tweets.count} do 
        Friends::GetTweets.run(friend: @friend, user: @user)
      end
      assert @friend.tweets.last.html_block.present?
    end
  end

  test 'check for duplicate tweets' do 
    use_cassette("user_signs_in") do 
      Friends::GetTweets.run(friend: @friend, user: @user)
      assert_not_changed -> { @friend.tweets.count } do 
        Friends::GetTweets.run(friend: @friend, user: @user)
      end
    end
  end

  test "check that tweets belong to user" do 
    use_cassette("user_signs_in") do 
      Friends::GetTweets.run(friend: @friend, user: @user)  
    end
    assert @user.tweets.count.present?
  end
end
