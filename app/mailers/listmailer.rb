class Listmailer < ApplicationMailer
  def list_updated_email(new_list, list)
    @user = list.user
    @email = @user.email
    @new_list = new_list
    @list = list
    mail(
      to: @email,
      subject: "Your new list has been created!"
    )
  end

  def user_logged_in_email(user)
    @user = user
    @email = user.email
    mail(
      to: @email,
      subject: "All of your information has been imported!"
    )
  end
end
