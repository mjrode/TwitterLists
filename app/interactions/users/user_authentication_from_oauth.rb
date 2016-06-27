class Users::UserAuthenticationFromOauth < Less::Interaction
  expects :auth_hash
  returns :user
  returns :message

  def run
    initialize_user
    self.message = set_message
    self.user = user
    Users::ImportTwitterAccountInformation.delay.run(user: self.user) if friends_count < 5_000
    self
  end

  private

  def initialize_user
    self.user = User.find_or_create_by(remote_id: auth_hash.uid)
    set_attributes
  end

  def set_message
    "Welcome, #{user.name}"
  end

  def friends_count
    set_twitter_client
    @client.user(user.username).friends_count
  end

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = user.token
      config.access_token_secret = user.secret
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
