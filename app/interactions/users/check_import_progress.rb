class Users::CheckImportProgress < Less::Interaction
  expects :user

  def run
    @client = Shared::SetTwitterClient.run(user: user)
    set_user
  end

  private

  def set_user
    @user ||= @client.user(user)
  end

  def total_friends
    @user.friends_count
  end

  def total_tweets
    
  end

end
