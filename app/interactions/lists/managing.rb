module Lists::Managing
  def randomized_list(list)
    @randomized_list ||= {}
    @randomized_list[list] ||= Lists::GenerateRandomizedList.run(list: list)
  end

  def update_remote_list_members(list)
    binding.pry
    result = Lists::UpdateRemoteListMembers.run(
      randomized_list_of_friends: randomized_list(list),
      list: list,
      user_id: user.id
    )
    set_success_and_message(result, list)
  end

  def email_list_updates(list)
    Listmailer.list_updated_email(randomized_list(list), list).deliver_later if list.user.email.present?
  end

  def set_success_and_message(result, list)
    if result
      self.success = true
      self.message = "Your list #{list.name.capitalize} has been updated" if respond_to?(:message=)
    else
      self.success = false
      list.destroy
      self.message = "That list is no longer available and has been removed" if respond_to?(:message=)
    end
  end

end