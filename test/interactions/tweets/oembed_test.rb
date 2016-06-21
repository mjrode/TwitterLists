require 'test_helper'

class Tweets::OembedTest < ActiveSupport::TestCase
  test 'it gets called' do
    Tweets::Oembed.run
    pass
  end
end
