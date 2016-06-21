require 'test_helper'

class Friends::GetTweetsTest < ActiveSupport::TestCase
  test 'it gets called' do
    Friends::GetTweets.run
    pass
  end
end
