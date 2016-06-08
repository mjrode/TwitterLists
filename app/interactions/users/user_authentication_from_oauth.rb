class Users::UserAuthenticationFromOauth < Less::Interaction
  expects :auth_hash
  returns :user
  returns :message

  def run
    initialize_user
    self.message = set_message
    self.user = user
    Users::ImportUsersFriends.run(user: self.user)
    Lists::ImportLists.run(username: self.user.username)
    self
  end

  private

  def initialize_user
    self.user = User.find_or_create_by(remote_id: auth_hash.uid)
    set_attributes
  end

  def set_message
    if user.email.present? 
      "Welcome, #{user.name}"  
    else
      "Click on the account dropdown to add your email address and get notified when your lists update."
    end
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
