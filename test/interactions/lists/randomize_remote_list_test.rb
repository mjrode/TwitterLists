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
      assert_changed -> { users(:mike).friends.count } do
        Lists::RandomizeRemoteList.run(user: users(:mike))
      end
    end
  end

end
