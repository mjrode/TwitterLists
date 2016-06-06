require 'test_helper'
class Lists::RandomizeListTest < ActiveSupport::TestCase
  test 'creates random list of friends' do
    random_list = Lists::RandomizeList.run(list: lists(:first_list))
    assert random_list.count == 3
  end
end
