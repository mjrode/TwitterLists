class Lists::CreateList < Less::Interaction
  expects_any :local_list, :name
  expects :user
  expects :days_until_rotation
  returns :success
  returns :message

  attr_writer :local_list
  def run
    get_local_list_from_name
    @client = Shared::SetTwitterClient.run(user: user)
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
      self.message = "Your list was successfully created!"
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
    remote_list = @client.create_list(local_list.name, mode: "private")
    create_local_copy(remote_list)
  end

  def create_local_copy(remote_list)
    local_list.update_attributes(
      name: remote_list.name,
      remote_id:  remote_list.id,
      user_id:  user.id,
      days_until_rotation: days_until_rotation,
      url: remote_list.url, 
      mode: 'private'
    )
  end
end
