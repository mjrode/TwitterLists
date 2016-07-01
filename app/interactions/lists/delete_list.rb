class Lists::DeleteList < Less::Interaction
  expects :list
  expects :user

  def run
    @client = Shared::SetTwitterClient.run(user: user)
    destroy_remote_list
  end

  private

  def destroy_remote_list
    @client.destroy_list(list.remote_id)
  end
end
