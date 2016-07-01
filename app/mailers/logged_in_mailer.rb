class LoggedInMailer < ApplicationMailer
  def user_logged_in_email(user)
    @user = user
    @email = user.email
    mail(
      to: @email,
      subject: "All of your information has been imported!"
    )
  end
end
