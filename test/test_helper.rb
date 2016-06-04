ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'vcr'
require 'mocha/mini_test'
require 'webmock/minitest'

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock 
end

module AssertChanged
  def assert_changed(lambda)
    initial = lambda.call
    yield
    final = lambda.call
    assert_not_equal initial, final, 'Expected object to change, but it did not'
  end

  def assert_not_changed(lambda)
    initial = lambda.call
    yield
    final = lambda.call
    assert_equal initial, final, 'Expected object not to change, but it did'
  end
end

class ActiveSupport::TestCase
  include AssertChanged
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...

  def use_cassette(name, &blk)
    VCR.use_cassette(name, record: :new_episodes, &blk)
  end
end

class ActiveJob::TestCase
  include AssertChanged
end
