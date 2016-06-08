require 'test_helper'

class ListmailerTest < ActionMailer::TestCase
  def setup
    @list = lists(:first_list)
    @email = "michaelrode44@gmail.com"
  end

  test 'email gets sent successfully' do
    assert_changed -> { ActionMailer::Base.deliveries.size } do
      Lists::RandomizeList.run(list: @list)
    end
    last_email = ActionMailer::Base.deliveries.last
    assert_equal @email, last_email.to.first
  end
end
