class Lists::CreateList < Less::Interaction
  expects_any :local_list, :name
  expects :user
  expects :days_until_rotation
  returns :success
  returns :message

  attr_writer :local_list
  def run
    get_local_list_from_name
    set_twitter_client
    attempt_to_create_list
    self
  end
  
  private

  def get_local_list_from_name
    self.local_list ||= List.find_or_create_by(name: name, user_id: user.id)
  end

  def attempt_to_create_list
    if unique
      create_remote_list
      self.success = true
    else
      self.message = "This name list name has already been taken"
      self.success = false
    end
  end

  def unique
    local_list.new_list?(user)
  end

  def create_remote_list
    remote_list = @client.create_list(local_list.name)
    create_local_copy(remote_list)
  end

  def create_local_copy(remote_list)
    local_list.update_attributes(
      name: remote_list.name,
      remote_id:  remote_list.id,
      user_id:  user.id,
      days_until_rotation: days_until_rotation
    )
  end

  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_secret_key"]
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
  end
end
