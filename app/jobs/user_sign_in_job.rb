class UserSignInJob < ActiveJob::Base
  queue_as :sign_in

  def perform(user)
    Users::ImportUsersFriends.run(user: user)
    Lists::ImportLists.run(username: user.username)
  end
end
