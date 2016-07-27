require 'test_helper'

class Lists::RandomizeRemoteListTest < ActiveSupport::TestCase
  def setup
    @user = User.create(
      username: "mjr_tts",
      token: '711995065347006465-JLJWrBLyfySojWUz1C7mwaqx37Qv7vQ',
      secret: 'Efmd45AlTJml6nIcsaBVjLuyZwPpx9Bn9ktICwiPxNIRF'
    )
  end

  test "new tweets are added to database" do 
    use_cassette('run_cron_job') do
    assert_changed -> { users(:mike).tweets.count } do
        Lists::RandomizeRemoteList.run(user: users(:mike))
      end
    end
  end

  test "new friends are saved on refresh" do 
    use_cassette('run_cron_job') do
      assert_changed -> { users(:mike).friends.count } do
        Lists::RandomizeRemoteList.run(user: users(:mike))
      end
    end
  end

  test 'past due lists get updated' do 
    use_cassette('run_cron_job') do 
      # do not know how to stub the random list 
      # since nothing is being saved unsure of what to test against 
      # looked into mocha to stub out the request but not sure waht to put for returns 
    end
  end

end

# -Test if refreshing user information was successful
# - We can check this by seeing if tweets and friends count increased after interaction is run 
# - 

# - Testing if new remote list was updated
# - Expects a user and a list 
# - Have a list which belongs to a user with the next_rotation_at date prior to today
# - The list needs to have friend_list_schedules so we can see if it was updated 
# - 