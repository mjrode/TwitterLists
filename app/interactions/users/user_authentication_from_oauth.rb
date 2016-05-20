class Users::UserAuthenticationFromOauth < Less::Interaction
  expects :auth_hash
  returns :user
  returns :message

  def run
    initialize_user
    self.message = "Welcome, #{user.name}!"
    Users::ImportLists.run(username: self.user.username)
    Users::ImportUsersFriends.run(user: self.user)
    self
  end

  private

  def initialize_user
    self.user = User.find_or_create_by(twitter_id: auth_hash.uid)
    set_attributes
  end

  def set_attributes
    info = auth_hash.info
    credentials = auth_hash.credentials
    user.update_attributes(
      username: info.nickname,
      name: info.name,
      location: info.location,
      image_url: info.image,
      url: info.urls.twitter,
      token: credentials.token,
      secret: credentials.secret
    )
  end
end
