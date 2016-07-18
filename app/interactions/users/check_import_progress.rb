class Users::CheckImportProgress < Less::Interaction
  expects :user

  def run
    @client = Shared::SetTwitterClient.run(user: user)
    friend_import_percentage
  end

  private

  def set_user
    @user ||= @client.user(user)
  end

  def total_friends
    # @total_friends ||= @client.user(@user.username).friends_count
    25
  end

  def friend_import_percentage
    result = (user.friends.count.to_d / total_friends.to_d)
    result *= 100
    return result.to_i if result.to_i < 100
    100
  end
end
