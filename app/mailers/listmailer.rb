class Listmailer < ApplicationMailer
  def list_updated_email(new_list, list)
    @user = list.user
    @email = @user.email
    @new_list = new_list
    @list = list
    mail(
      to: @email,
      subject: "Your list has been updated"
    )
  end
end
