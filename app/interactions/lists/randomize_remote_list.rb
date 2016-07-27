class Lists::RandomizeRemoteList < Less::Interaction
  include Lists::Managing

  expects :user

  # We need this when sending list update emails, but we're not actually returning it
  attr_accessor :success 

  def run
    refresh_user_information
    return if lists_to_update.empty?

    lists_to_update.each do |list|
      update_remote_list_members(list)
      email_list_updates(list) if success
    end
  end

  private

  def refresh_user_information
    Users::ImportTwitterAccountInformation.run(user: user)
  end

  def lists_to_update
    user.lists.where('lists.next_rotation_at < ?', Time.current)
  end
end
